//
//  ProfileVC.swift
//  Capture The Creative
//
//  Created by Martynas Blazys on 04/03/2017.
//  Copyright © 2017 Martynas Blazys. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FBSDKLoginKit

class ProfileVC: UIViewController {
    
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var fullnameLabel: UILabel!
    @IBOutlet var usernameLabel: UILabel!
    
    var databaseRef: FIRDatabaseReference!
    
    override func viewDidLoad() {
        
        // Settings for profile image
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2
        self.profileImage.layer.borderWidth = 1
        self.profileImage.layer.borderColor = UIColor.black.cgColor
        self.profileImage.clipsToBounds = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        retrieveUserInfo()
    }
    
    func retrieveUserInfo() {
        
        databaseRef = FIRDatabase.database().reference()
        
        if let userID = FIRAuth.auth()?.currentUser?.uid {
            databaseRef.child("users").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
                
                let dictionary = snapshot.value as? NSDictionary
                
                let fullname = dictionary?["fullname"] as? String
                let username = dictionary?["username"] as? String
                
                if let photoURL = dictionary?["photoURL"] as? String {
                    let url = URL(string: photoURL)
                    
                    // Download the profile image
                    self.profileImage.sd_setImage(with: url)
                    
                }
                
                self.fullnameLabel.text = fullname
                self.usernameLabel.text = username
                
            }) { (error) in
                let alert = UIAlertController(title: "Profile Page Error", message: (error.localizedDescription) as String, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
        }
    }
    
    @IBAction func handleLogoutButton(_ sender: Any) {
        
        do {
            try FIRAuth.auth()?.signOut()
        } catch {
            
            let alert = UIAlertController(title: "Logout Error", message: error.localizedDescription, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        FBSDKAccessToken.current()
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
        
        // Present the login screen
        if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "Login") {
            UIApplication.shared.keyWindow?.rootViewController = viewController
            self.dismiss(animated: true, completion: nil)
        }
    }
}
