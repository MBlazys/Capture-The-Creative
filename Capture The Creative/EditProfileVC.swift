//
//  EditProfileVC.swift
//  Capture The Creative
//
//  Created by Martynas Blazys on 09/03/2017.
//  Copyright © 2017 Martynas Blazys. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class EditProfileVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var fullnameTextField: UITextField!
    @IBOutlet var websiteTextField: UITextField!
    @IBOutlet var bioTextField: UITextField!
    
    var databaseRef: FIRDatabaseReference!
    var storageRef: FIRStorageReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        databaseRef = FIRDatabase.database().reference()
        storageRef = FIRStorage.storage().reference()
        
        // Settings for profile image
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2
        self.profileImage.layer.borderWidth = 1
        self.profileImage.layer.borderColor = UIColor.black.cgColor
        self.profileImage.clipsToBounds = true
        
        // Loads user info from firebase
        loadUserInfo()
        
    }
    
    @IBAction func handleCancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // Change profile picture
    @IBAction func handleChangeProfilePhoto(_ sender: Any) {
        handleSelectProfileImageFromLibrary()
    }
    
    // Save button on EditProfileVC
    @IBAction func handleSave(_ sender: Any) {
        updateUserProfile()
        self.dismiss(animated: true, completion: nil)
    }
    
    // Function to upload and update all data into the Firebase
    func updateUserProfile() {
        
        if let userID = FIRAuth.auth()?.currentUser?.uid {
            
            let storageItem = storageRef.child("user_profile_photos").child(userID)
            
            guard let image = profileImage.image else {return}
            
            if let updatedImage = UIImageJPEGRepresentation(image, 0.5) {
                
                // update image in the Firebase Storage
                storageItem.put(updatedImage, metadata: nil, completion: { (metadata, error) in
                    
                    if error != nil {
                        
                        let alert = UIAlertController(title: "Upload Error", message: error?.localizedDescription, preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alert.addAction(okAction)
                        self.present(alert, animated: true, completion: nil)
                        
                        return
                    }
                    
                    storageItem.downloadURL(completion: { (url, error) in
                        if error != nil {
                            
                            let alert = UIAlertController(title: "Upload Error", message: error?.localizedDescription, preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            alert.addAction(okAction)
                            self.present(alert, animated: true, completion: nil)
                            
                            return
                        }
                        
                        if let photoURL = url?.absoluteString {
                            
                            guard let updatedUsername = self.usernameTextField.text else {return}
                            guard let updatedFullname = self.fullnameTextField.text else {return}
                            guard let updatedWebsite = self.websiteTextField.text else {return}
                            guard let updatedBio = self.bioTextField.text else {return}
                            
                            let updatedValues = ["photoURL": photoURL,
                                                 "username": updatedUsername,
                                                 "fullname": updatedFullname,
                                                 "website": updatedWebsite,
                                                 "bio": updatedBio]
                            
                            // Updata data in Firebase Database
                            self.databaseRef.child("users").child(userID).updateChildValues(updatedValues, withCompletionBlock: { (error, ref) in
                                
                                if error != nil {
                                    let alert = UIAlertController(title: "Upload Error", message: error?.localizedDescription, preferredStyle: .alert)
                                    let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                                    alert.addAction(okAction)
                                    self.present(alert, animated: true, completion: nil)
                                    
                                    return
                                }
                                
                                
                                
                            })
                            
                        }
                        
                    })
                    
                })
                
            }
            
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func loadUserInfo() {
        
        if let userID = FIRAuth.auth()?.currentUser?.uid {
            
            databaseRef.child("users").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
                
                let values = snapshot.value as? NSDictionary
                
                // Download user profile photo
                if let photoURL = values?["photoURL"] as? String {
                    self.profileImage.sd_setImage(with: URL(string: photoURL))
                }
                
                // Set text fields to the current data
                self.usernameTextField.text = values?["username"] as? String
                self.fullnameTextField.text = values?["fullname"] as? String
                self.websiteTextField.text = values?["website"] as? String
                self.bioTextField.text = values?["bio"] as? String
                
            })
            
        }
        
    }
    
}
