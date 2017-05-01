//
//  LoginVC.swift
//  Capture The Creative
//
//  Created by Martynas Blazys on 04/03/2017.
//  Copyright © 2017 Martynas Blazys. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var backgroundImage: UIImageView!
    @IBOutlet var logo: UIImageView!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Delegates
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        // Apply Outlet settings from LoginVCOutletSettings.swift file
        loginVCOutletSettings()
        
        // Apply Keyboard settings from LoginVCKeyboard.swift file
        hideKeyboardOnTap() // hides keyboard when tapped anywhere on a screen
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // If user is already logged in, go to Main Screen
        if FIRAuth.auth()?.currentUser?.uid != nil {
            goToMainScreen()
        }
        
    }
    
    func goToMainScreen() {
        
        // Present MyProfileVC
        let viewConrolller = self.storyboard?.instantiateViewController(withIdentifier: "tabbar") as! UITabBarController
        self.present(viewConrolller, animated: true, completion: nil)
        
    }
    
    // Hide status bar e.g. Time, Battery Life
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func handleLoginTapped(_ sender: Any) {
        
        // Login auth
        emailLogin()
        
    }
    
}
