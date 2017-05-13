//
//  FBUser.swift
//  Capture The Creative
//
//  Created by Martynas Blazys on 09/03/2017.
//  Copyright © 2017 Martynas Blazys. All rights reserved.
//

import UIKit

class FBUser {
    
    var email: String!
    var uid: String!
    
    init(email: String, uid: String) {
        self.email = email
        self.uid = uid
    }
    
    func getUserDictionary() -> Dictionary<String, String> {
        let userDictionary = ["email": self.email,
                              "uid": self.uid]
        
        return userDictionary as! Dictionary<String, String>
    }
    
}
