//
//  Post.swift
//  Capture The Creative
//
//  Created by Martynas Blazys on 16/03/2017.
//  Copyright © 2017 Martynas Blazys. All rights reserved.
//

import UIKit

class Post: NSObject {

    var title: String!
    var desc: String!
    var photoURL: String!
    var uid: String!
    var username: String!
    var likes: Int!
    var postKey: String!
    
    init(title: String, desc: String, photoURL: String, uid: String, username: String, likes: Int, postKey: String) {
        self.title = title
        self.desc = desc
        self.photoURL = photoURL
        self.uid = uid
        self.username = username
        self.likes = likes
        self.postKey = postKey
    }
    
    func getPostDictionary() -> Dictionary<String, AnyObject> {
        let postDictionary = ["title": self.title,
                              "description": self.desc,
                              "photoURL": self.photoURL,
                              "uid": self.uid,
                              "username": self.username,
                              "likes": self.likes,
                              "postKey": self.postKey] as [String : Any]
        
        return postDictionary as Dictionary<String, AnyObject>
    }
    
}
