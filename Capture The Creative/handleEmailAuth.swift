//
//  handleEmailAuth.swift
//  Capture The Creative
//
//  Created by Martynas Blazys on 04/03/2017.
//  Copyright © 2017 Martynas Blazys. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

extension RegisterVC {
    
    func emailAuth() {
        
        // Validate the input
        guard let username = usernameTextField.text, username != "",
            let fullname = fullnameTextField.text, fullname != "",
            let email = emailTextField.text, email != "",
            let password = passwordTextField.text, password != "",
            let repeatPassword = repeatPasswordTextField.text, repeatPassword != ""
            
            else {
                
                let alert = UIAlertController(title: "Registration Error", message: "Please make sure you filled in all of the boxes to complete registration!", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(okAction)
                present(alert, animated: true, completion: nil)
                
                return
        }
        
        
        if password == repeatPassword { // checks if the passwords are the same
            
            // Register a new user on Firebase
            
            FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                
                if let error = error {
                    let alert = UIAlertController(title: "Registration Error", message: error.localizedDescription, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                    
                    return
                }
                
                guard let userID = user?.uid else {
                    return
                }
                
                // Save the name of the user
                
                if let changeRequest = FIRAuth.auth()?.currentUser?.profileChangeRequest() {
                    changeRequest.displayName = username
                    changeRequest.commitChanges(completion: { (error) in
                        if let error = error {
                            
                            let alert = UIAlertController(title: "Registration Error", message: error.localizedDescription, preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            alert.addAction(okAction)
                            self.present(alert, animated: true, completion: nil)
                            
                            return
                        }
                    })
                }
                
                // Create a new user with info
                
                // Database reference
                let databaseRef = FIRDatabase.database().reference(fromURL: "https://capture-the-creative-cf421.firebaseio.com/")
                
                // Storage reference
                let storageRef = FIRStorage.storage().reference(forURL: "gs://capture-the-creative-cf421.appspot.com/")
                
                let imageRef = storageRef.child("user_profile_photos").child(userID)
                let imageData = UIImageJPEGRepresentation(self.profileImage.image!, 0.5)
                let uploadImage = imageRef.put(imageData!, metadata: nil, completion: { (metadata, imageUploadError) in
                    
                    if imageUploadError != nil {
                        let alert = UIAlertController(title: "Upload Error", message: (imageUploadError?.localizedDescription)! as String, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                    imageRef.downloadURL(completion: { (url, downloadUrlError) in
                        if downloadUrlError != nil {
                            let alert = UIAlertController(title: "Dowload Error", message: (downloadUrlError?.localizedDescription)! as String, preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                        
                        let userInfo = User(email: email, fullname: fullname, photoURL: url!.absoluteString, uid: user!.uid, username: user!.displayName!)
                        
                        databaseRef.child("users").child(userID).updateChildValues(userInfo.getUserDictionary(), withCompletionBlock: { (err, databaseRef) in
                            
                            if err != nil {
                                let alert = UIAlertController(title: "Error", message: (err?.localizedDescription)! as String, preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                                self.present(alert, animated: true, completion: nil)
                                
                            }
                        })
                    })
                    
                })
                
                uploadImage.resume()
                
                // Dismiss keyboard
                self.view.endEditing(true)
                
                // Present MyProfileVC
                let viewConrolller = self.storyboard?.instantiateViewController(withIdentifier: "Profile") as! ProfileVC
                let navController = UINavigationController(rootViewController: viewConrolller)
                self.present(navController, animated: true, completion: nil)
                
            })
            
        } else {
            
            let alert = UIAlertController(title: "Error", message: "Passwords don't match!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
}
