//
//  handleFBAuth.swift
//  Capture The Creative
//
//  Created by Martynas Blazys on 07/05/2017.
//  Copyright © 2017 Martynas Blazys. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
import FBSDKCoreKit

extension RegisterVC {
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        if error != nil {
            
            // Error occured
            let alert = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
            
        else if result.isCancelled {
            
            // User cancelled the login
            self.dismiss(animated: true, completion: nil)
        }
            
        else {
            
            // Successfully logged in
            let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
            
            // Sign in user with credentials to Firebase
            FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
                
                // Database reference
                let databaseRef = FIRDatabase.database().reference(fromURL: "https://capture-the-creative-cf421.firebaseio.com/")
                
                guard let userID = user?.uid else {
                    return
                }
                
                let graphRequest: FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"])
                graphRequest.start(completionHandler: { (connection, result, error) in
                    if error != nil {
                        
                        // Error occured
                        let alert = UIAlertController(title: "Information error", message: error?.localizedDescription, preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alert.addAction(okAction)
                        self.present(alert, animated: true, completion: nil)
                    }
                        
                    else {
                        
                        if let result = result as? [String: Any] {
                            
                            let email: String = result["email"] as! String
                            
                            let userInfo = FBUser(email: email, uid: userID)
                            
                            databaseRef.child("users").child(userID).updateChildValues(userInfo.getUserDictionary(), withCompletionBlock: { (err, databaseRef) in
                                
                                if err != nil {
                                    let alert = UIAlertController(title: "Error", message: (err?.localizedDescription)! as String, preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                                    self.present(alert, animated: true, completion: nil)
                                    
                                }
                            })
                        }
                    }
                })
                
                // Present Tabbar
                let viewConrolller = self.storyboard?.instantiateViewController(withIdentifier: "tabbar") as! UITabBarController
                self.present(viewConrolller, animated: true, completion: nil)
            })
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
    }
    
    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    
}
