//
//  UsersVC.swift
//  Capture The Creative
//
//  Created by Martynas Blazys on 30/04/2017.
//  Copyright © 2017 Martynas Blazys. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class UsersVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    var follower = [Follower]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        retrieveUsers()
        
    }
    
    func retrieveUsers() {
        
        let databaseRef = FIRDatabase.database().reference()
        
        databaseRef.child("users").queryOrderedByKey().observeSingleEvent(of: .value, with: { (retrieveUsersSnapshot) in
            
            let users = retrieveUsersSnapshot.value as! [String: AnyObject]
            self.follower.removeAll()
            for (_, value) in users {
                if let uid = value["uid"] as? String {
                    
                    if uid != FIRAuth.auth()!.currentUser!.uid {
                        let userToShow = Follower()
                        if let username = value["username"] as? String,
                            let fullname = value["fullname"] as? String,
                            let photoURL = value["photoURL"] as? String {
                            
                            userToShow.username = username
                            userToShow.fullname = fullname
                            userToShow.photoURL = photoURL
                            userToShow.uid = uid
                            
                            self.follower.append(userToShow)
                        }
                    }
                }
            }
            
            self.tableView.reloadData()
        })
        
        databaseRef.removeAllObservers()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserCell
        
        // Set profile image, username and fullname here...
        cell.usernameTextField.text = self.follower[indexPath.row].username
        cell.fullnameTextField.text = self.follower[indexPath.row].fullname
        cell.userID = self.follower[indexPath.row].uid
        
        if let photoURL = self.follower[indexPath.row].photoURL {
            let url = URL(string: photoURL)
            
            // Download the profile image
            cell.profileImage.sd_setImage(with: url)
        }
        
        // Execute checkFollowing function to check if user already follows someone
        checkFollowing(indexPath: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return follower.count 
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let userID = FIRAuth.auth()!.currentUser!.uid
        let ref = FIRDatabase.database().reference()
        let key = ref.child("users").childByAutoId().key
        
        var isFollower = false
        
        // Unfollow
        ref.child("users").child(userID).child("following").queryOrderedByKey().observeSingleEvent(of: .value, with: { snapshot in
            
            if let following = snapshot.value as? [String : AnyObject] {
                for (item, value) in following {
                    if value as! String == self.follower[indexPath.row].uid {
                        isFollower = true
                        
                        ref.child("users").child(userID).child("following/\(item)").removeValue()
                        ref.child("users").child(self.follower[indexPath.row].uid).child("followers/\(item)").removeValue()
                        
                        self.tableView.cellForRow(at: indexPath)?.accessoryType = .none
                    }
                }
            }
            
            // Follow
            if !isFollower {
                
                let following = ["following/\(key)" : self.follower[indexPath.row].uid]
                let followers = ["followers/\(key)" : userID]
                
                ref.child("users").child(userID).updateChildValues(following as Any as! [AnyHashable : Any])
                ref.child("users").child(self.follower[indexPath.row].uid).updateChildValues(followers)
                
                self.tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            }
        })
        
        ref.removeAllObservers()
    }
    
    // Checks if the user is already following another user
    func checkFollowing(indexPath: IndexPath) {
        
        let userID = FIRAuth.auth()!.currentUser!.uid
        let ref = FIRDatabase.database().reference()
        
        ref.child("users").child(userID).child("following").queryOrderedByKey().observeSingleEvent(of: .value, with: { snapshot in
            
            if let following = snapshot.value as? [String : AnyObject] {
                for (_, value) in following {
                    if value as! String == self.follower[indexPath.row].uid {
                        self.tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
                    }
                }
            }
        })
        
        ref.removeAllObservers()
    }
}
