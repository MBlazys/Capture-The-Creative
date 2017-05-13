//
//  uploadPost.swift
//  Capture The Creative
//
//  Created by Martynas Blazys on 17/03/2017.
//  Copyright © 2017 Martynas Blazys. All rights reserved.
//

import UIKit
import Firebase

extension PostVC {
    
    func uploadPost() {
        
        // Validate the input
        guard let title = titleTextField.text, title != "",
              let desc = descriptionTextView.text, desc != ""
        
            else {
                
                let alert = UIAlertController(title: "Registration Error", message: "Please make sure you filled in all of the boxes to post!", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(okAction)
                present(alert, animated: true, completion: nil)
                
                return
        }
        
        
        if let userID = FIRAuth.auth()?.currentUser?.uid {
            
            // Database reference
            let databaseRef = FIRDatabase.database().reference(fromURL: "https://capture-the-creative-cf421.firebaseio.com/")
            
            // Storage reference
            let storageRef = FIRStorage.storage().reference(forURL: "gs://capture-the-creative-cf421.appspot.com/")
            
            let key = databaseRef.child("posts").childByAutoId().key
            let imageRef = storageRef.child("user_posted_photos").child(userID).child(key)
            let imageData = UIImageJPEGRepresentation(self.imageView.image!, 1.0)
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
                    
                    databaseRef.child("users").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
                        
                        let dictionary = snapshot.value as? NSDictionary
                        
                        let fullname = dictionary?["fullname"] as? String
                        let profileURL = dictionary?["photoURL"] as? String
                        
                        let postInfo = Post(title: title, desc: desc, photoURL: url!.absoluteString, uid: userID, username: FIRAuth.auth()!.currentUser!.displayName!, likes: "0", postID: key, timestamp: NSNumber(value: Int(NSDate().timeIntervalSince1970)), fullname: fullname!, profileURL: profileURL!)
    
                        databaseRef.child("posts").child(userID).child(key).updateChildValues(postInfo.getPostDictionary(), withCompletionBlock: { (err, databaseRef) in
                            
                            if err != nil {
                                let alert = UIAlertController(title: "Error", message: (err?.localizedDescription)! as String, preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                                self.present(alert, animated: true, completion: nil)
                                
                            }
                        })
                        
                        guard let lat = self.latitude else {return}
                        guard let long = self.longitude else {return}
                        
                        let coordinates = ["latidute": lat,
                                           "longitude": long]
                        databaseRef.child("posts").child(userID).child(key).updateChildValues(coordinates, withCompletionBlock: { (err, databaseRef) in
                            
                            if err != nil {
                                let alert = UIAlertController(title: "Error", message: (err?.localizedDescription)! as String, preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                                self.present(alert, animated: true, completion: nil)
                                
                            }
                        })
                        
                    })
                    
                    
                })
                
            })
            
            uploadImage.resume()
            
            // Dismiss keyboard
            self.view.endEditing(true)
            
            // Present Tabbar
            let viewConrolller = self.storyboard?.instantiateViewController(withIdentifier: "tabbar") as! UITabBarController
            self.present(viewConrolller, animated: true, completion: nil)
            
        }
    }
}
