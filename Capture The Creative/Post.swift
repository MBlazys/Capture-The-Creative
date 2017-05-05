//
//  Post.swift
//  Capture The Creative
//
//  Created by Martynas Blazys on 16/03/2017.
//  Copyright © 2017 Martynas Blazys. All rights reserved.
//

import UIKit
import Foundation
import IGListKit

class Post {

    var title: String!
    var desc: String!
    var photoURL: String!
    var uid: String!
    var username: String!
    var likes: String!
    var postID: String!
    var timestamp: NSNumber!
    var fullname: String!
    var profileURL: String!
    
    init(title: String, desc: String, photoURL: String, uid: String, username: String, likes: String!, postID: String, timestamp: NSNumber, fullname: String!, profileURL: String!) {
        
        self.title = title
        self.desc = desc
        self.photoURL = photoURL
        self.uid = uid
        self.username = username
        self.likes = likes
        self.postID = postID
        self.timestamp = timestamp
        self.fullname = fullname
        self.profileURL = profileURL
        
    }
    
    func getPostDictionary() -> Dictionary<String, AnyObject> {
        let postDictionary = ["title": self.title,
                              "description": self.desc,
                              "photoURL": self.photoURL,
                              "uid": self.uid,
                              "username": self.username,
                              "likes": self.likes,
                              "postID": self.postID,
                              "timestamp": self.timestamp,
                              "fullname": self.fullname,
                              "profileURL": self.profileURL] as [String : Any]
        
        return postDictionary as Dictionary<String, AnyObject>
    }
}

extension Post: Equatable {
    static public func == (rhs: Post, lhs: Post) -> Bool {
        return rhs.postID == lhs.postID
    }
}

extension Post: IGListDiffable {
    
    public func diffIdentifier() -> NSObjectProtocol {
        return postID as NSObjectProtocol
    }

    public func isEqual(toDiffableObject object: IGListDiffable?) -> Bool {
        guard let object = object as? Post else {
        return false
        }
        
    return self.postID == object.postID
    }
}


