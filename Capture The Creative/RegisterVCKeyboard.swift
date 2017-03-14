//
//  RegisterVCKeyboard.swift
//  Capture The Creative
//
//  Created by Martynas Blazys on 04/03/2017.
//  Copyright © 2017 Martynas Blazys. All rights reserved.
//

import UIKit

extension RegisterVC {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == usernameTextField {
            textField.resignFirstResponder()
            fullnameTextField.becomeFirstResponder()
        }
            
        else if textField == fullnameTextField {
            textField.resignFirstResponder()
            emailTextField.becomeFirstResponder()
        }
            
            
        else if textField == emailTextField {
            textField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        }
            
        else if textField == passwordTextField {
            textField.resignFirstResponder()
            repeatPasswordTextField.becomeFirstResponder()
        }
            
        else if textField == repeatPasswordTextField {
            // change later to autherisation function
        }
        
        return true
    }
    
    func hideKeyboardOnTap() {
        let hideTap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        hideTap.numberOfTapsRequired = 1
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(hideTap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
