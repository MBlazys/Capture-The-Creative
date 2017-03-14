//
//  User.swift
//  Capture The Creative
//
//  Created by Martynas Blazys on 09/03/2017.
//  Copyright © 2017 Martynas Blazys. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var email: String!
    var fullname: String!
    var photoURL: String!
    var uid: String!
    var username: String!
    
    init(email: String, fullname: String, photoURL: String, uid: String, username: String) {
        self.email = email
        self.fullname = fullname
        self.photoURL = photoURL
        self.uid = uid
        self.username = username
    }
    
    func getUserDictionary() -> Dictionary<String, String> {
        let userDictionary = ["email": self.email,
                              "fullname": self.fullname,
                              "photoURL": self.photoURL,
                              "uid": self.uid,
                              "username": self.username]
        
        return userDictionary as! Dictionary<String, String>
    }
    
}
