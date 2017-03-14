//
//  LoginVCOutletSettings.swift
//  Capture The Creative
//
//  Created by Martynas Blazys on 04/03/2017.
//  Copyright © 2017 Martynas Blazys. All rights reserved.
//

import UIKit

extension LoginVC {
    
    func loginVCOutletSettings() {
        backgroundImageSettings()
        logoImageSettings()
        emailTextFieldSettings()
        passwordTextFieldSettings()
        loginButtonSettings()
    }
    
    func backgroundImageSettings() {
        // Backrgound Image settings:
        backgroundImage.image = UIImage(named: "loginBackground.jpg")
    }
    
    func logoImageSettings() {
        // Logo image settings:
        logo.image = UIImage(named: "logo.jpg")
    }
    
    func emailTextFieldSettings(){
        // Email text box settings:
        emailTextField.attributedPlaceholder = NSAttributedString(string: "EMAIL", attributes: [NSForegroundColorAttributeName: UIColor.darkGray]) // set EMAIL colour to darkGray
    }
    
    func passwordTextFieldSettings(){
        // Password text box settings:
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "PASSWORD", attributes: [NSForegroundColorAttributeName: UIColor.darkGray]) // set PASSWORD colour to darkGray
    }
    
    func loginButtonSettings() {
        // Login button settings:
        loginButton.layer.cornerRadius = 20 // rounded login button
    }
}
