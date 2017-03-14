//
//  LoginVCKeyboard.swift
//  Capture The Creative
//
//  Created by Martynas Blazys on 04/03/2017.
//  Copyright © 2017 Martynas Blazys. All rights reserved.
//

import UIKit

extension LoginVC {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            textField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        }
            
        else if textField == passwordTextField {
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
