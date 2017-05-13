//
//  FeedVC.swift
//  Capture The Creative
//
//  Created by Martynas Blazys on 02/05/2017.
//  Copyright © 2017 Martynas Blazys. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage
import IGListKit


class FeedVC: UIViewController {
    
    lazy var adapter: IGListAdapter = {
        return IGListAdapter(updater: IGListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()
    
    @IBOutlet var collectionView: IGListCollectionView!
    

    var databaseRef: FIRDatabaseReference!
    var feedArray = [Post]()
    var following = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        databaseRef = FIRDatabase.database().reference()
        
        self.collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchPosts()
    }
    
    @IBAction func handleRefreshButtonH(_ sender: Any) {
        
        fetchPosts()
    }

    func fetchPosts() {
        
        let databaseRef = FIRDatabase.database().reference()
        
        // retrieves all users from database
        databaseRef.child("users").queryOrderedByKey().observeSingleEvent(of: .value, with: { (usersSnapshot) in
            
            let users = usersSnapshot.value as! [String: AnyObject]
            
            // retrieve user's following list and append it
            for (_, value) in users {
                
                if let userID = value["uid"] as? String {
                    if userID == FIRAuth.auth()?.currentUser?.uid {
                        
                        if let followingUsers = value["following"] as? [String : String] {
                            
                            for (_,user) in followingUsers{
                                
                                self.following.append(user)
                            }
                        }
                        
                        // append user's id to see own posts
                        self.following.append(FIRAuth.auth()!.currentUser!.uid)
                        
                        // retrieve all posts from the database
                        databaseRef.child("posts").queryOrderedByKey().observeSingleEvent(of: .value, with: { (postsSnapshot) in
                            
                            let posts = postsSnapshot.value as! [String: AnyObject]
                            
                            // retrieve posts of each follower and user
                            for (_, post) in posts {
                                
                                for (_, postInfo) in post as! [String: AnyObject] {
                                    
                                    if let followingID = postInfo["uid"] as? String {
                                        
                                        for each in self.following {
                                            
                                            if each == followingID {
                                                
                                                guard let photoURL = postInfo["photoURL"] as! String! else {return}
                                                guard let username = postInfo["username"] as! String! else {return}
                                                guard let title = postInfo["title"] as! String! else {return}
                                                guard let description = postInfo["description"] as! String! else {return}
                                                guard let timestamp = postInfo["timestamp"] as! NSNumber! else {return}
                                                guard let fullname = postInfo["fullname"] as! String! else {return}
                                                guard let profileURL = postInfo["profileURL"] as! String! else {return}
                                                guard let postID = postInfo["postID"] as! String! else {return}
                                                guard let likes = postInfo["likes"] as! String! else {return}
                                                
                                                self.feedArray.append(Post(title: title, desc: description, photoURL: photoURL, uid: userID, username: username, likes: likes, postID: postID, timestamp: timestamp, fullname: fullname, profileURL: profileURL))
                                            }
                                            
                                            // append to the feed array
                                            self.adapter.performUpdates(animated: true, completion: nil)
                                        }
                                    }
                                }
                            }
                        }) { (error) in
                            print(error.localizedDescription)
                        }
                    }
                }
            }
        })
    }
}

extension FeedVC: IGListAdapterDataSource {
    
    public func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
        
        let feedItem: [IGListDiffable] = feedArray
        return feedItem
        
    }
    
    public func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {
        
        return PostSectionController()
        
    }
    
    public func emptyView(for listAdapter: IGListAdapter) -> UIView? {
        
        let view = UIView()
        view.backgroundColor = .white
        return view
        
    }
    
}

