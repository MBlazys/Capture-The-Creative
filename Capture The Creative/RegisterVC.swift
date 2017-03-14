//
//  RegisterVC.swift
//  Capture The Creative
//
//  Created by Martynas Blazys on 04/03/2017.
//  Copyright © 2017 Martynas Blazys. All rights reserved.
//

import UIKit
import Firebase

class RegisterVC: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var backgroundImage: UIImageView!
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var fullnameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var repeatPasswordTextField: UITextField!
    @IBOutlet var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Delegates
        usernameTextField.delegate = self
        fullnameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        repeatPasswordTextField.delegate = self
        
        // Apply Outlet settings from RegisterVCOutletSettings.swift file
        registerVCOutletSettings()
        
        // Apply Keyboard settings from RegisterVCKeyboard.swift
        hideKeyboardOnTap() // hides keyboard when tapped anywhere on a screen
        
        // Adds ability to choose a profile picture
        profileImage.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImageFromLibrary))
        self.profileImage.addGestureRecognizer(gestureRecognizer)
    }
    
    // Hide status bar e.g. Time, Battery Life
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func handleRegisterButton(_ sender: UIButton) {
        
        emailAuth() // handleEmailAuth.swift
        
    }
    
    
}
