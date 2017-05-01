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
    var likes: Int!
    var postID: String!
    
    init(title: String, desc: String, photoURL: String, uid: String, username: String, likes: Int, postID: String) {
        self.title = title
        self.desc = desc
        self.photoURL = photoURL
        self.uid = uid
        self.username = username
        self.likes = likes
        self.postID = postID
    }
    
    func getPostDictionary() -> Dictionary<String, AnyObject> {
        let postDictionary = ["title": self.title,
                              "description": self.desc,
                              "photoURL": self.photoURL,
                              "uid": self.uid,
                              "username": self.username,
                              "likes": self.likes,
                              "postID": self.postID] as [String : Any]
        
        return postDictionary as Dictionary<String, AnyObject>
    }
}

extension Post: Equatable {
    static public func == (rhs: Post, lhs: Post) -> Bool {
        return rhs.postID == lhs.postID
    }
}

extension Post: IGListDiffable {
    /**
     Returns whether the receiver and a given object are equal.
     
     @param object The object to be compared to the receiver.
     
     @return `YES` if the receiver and object are equal, otherwise `NO`.
     */
    func isEqual(toDiffableObject object: IGListDiffable?) -> Bool {
        guard let object = object as? Post else {
            return false
        }
        
        return self.postID == object.postID
    }

    public func diffIdentifier() -> NSObjectProtocol {
        return postID as NSObjectProtocol
    }
}


