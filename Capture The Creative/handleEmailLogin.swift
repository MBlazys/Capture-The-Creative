//
//  handleEmailLogin.swift
//  Capture The Creative
//
//  Created by Martynas Blazys on 04/03/2017.
//  Copyright © 2017 Martynas Blazys. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

extension LoginVC {
    
    func emailLogin() {
        
        // Validate the input
        guard let email = emailTextField.text, email != "",
            let password = passwordTextField.text, password != ""
            
            else {
                
                let alert = UIAlertController(title: "Login Error", message: "Please make sure you filled in all of the boxes to login!", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(okAction)
                present(alert, animated: true, completion: nil)
                
                return
                
        }
        
        // Perform login with Firebase
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            
            if let error = error {
                
                let alert = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
                
                return
                
            }
            
            // Dismiss keyboard
            self.view.endEditing(true)
            
            // Present MyProfileVC
            let viewConrolller = self.storyboard?.instantiateViewController(withIdentifier: "Profile") as! ProfileVC
            let navController = UINavigationController(rootViewController: viewConrolller)
            self.present(navController, animated: true, completion: nil)
            
            
            
        })
    }
}
