//
//  RegisterVCOutletSettings.swift
//  Capture The Creative
//
//  Created by Martynas Blazys on 04/03/2017.
//  Copyright © 2017 Martynas Blazys. All rights reserved.
//

import UIKit

extension RegisterVC {
    
    func registerVCOutletSettings() {
        backgroundImageSettings()
        profileImageSettings()
        usernameTextFieldSettings()
        fullnameTextFieldSettings()
        emailTextFieldSettings()
        passwordTextFieldSettings()
        repeatPasswordTextFieldSettings()
        registerButtonTextFieldSettings()
    }
    
    func backgroundImageSettings() {
        // Backrgound Image settings:
        backgroundImage.image = UIImage(named: "loginBackground.jpg")
    }
    
    func profileImageSettings() {
        // Profile image settings:
        profileImage.image = UIImage(named: "addProfileImage.jpg")
    }
    
    func usernameTextFieldSettings() {
        // Username text box settings:
        usernameTextField.attributedPlaceholder = NSAttributedString(string: "USERNAME", attributes: [NSForegroundColorAttributeName: UIColor.darkGray]) // set USERNAME colour to darkGray
    }
    
    func fullnameTextFieldSettings() {
        // Fullname text box settings:
        fullnameTextField.attributedPlaceholder = NSAttributedString(string: "FULL NAME", attributes: [NSForegroundColorAttributeName: UIColor.darkGray]) // set FULL NAME colour to darkGray
    }
    
    func emailTextFieldSettings() {
        // Email text box settings:
        emailTextField.attributedPlaceholder = NSAttributedString(string: "EMAIL", attributes: [NSForegroundColorAttributeName: UIColor.darkGray]) // set EMAIL colour to darkGray
    }
    
    func passwordTextFieldSettings() {
        // Password text box settings:
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "PASSWORD", attributes: [NSForegroundColorAttributeName: UIColor.darkGray]) // set PASSWORD colour to darkGray
    }
    
    func repeatPasswordTextFieldSettings() {
        // Repeat password text box settings:
        repeatPasswordTextField.attributedPlaceholder = NSAttributedString(string: "REPEAT PASSWORD", attributes: [NSForegroundColorAttributeName: UIColor.darkGray]) // set REPEAT PASSWORD colour to darkGray
    }
    
    func registerButtonTextFieldSettings() {
        // Register button settings:
        registerButton.layer.cornerRadius = 20 // rounded register button
    }
    
    
}
