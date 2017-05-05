//
//  PostSectionController.swift
//  Capture The Creative
//
//  Created by Martynas Blazys on 02/05/2017.
//  Copyright © 2017 Martynas Blazys. All rights reserved.
//

import UIKit
import IGListKit
import Reusable
import SDWebImage

class PostSectionController: IGListSectionController {

    override init() {
        super.init()
        inset = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
    }
    
    var post: Post!

}



extension PostSectionController: IGListSectionType {
    public func numberOfItems() -> Int {
        
        return 1
    }
    
    public func sizeForItem(at index: Int) -> CGSize {
        
        guard let context = collectionContext else { return .zero }
        let width = context.containerSize.width
        let contextHeight = context.containerSize.height
        let requiredHeight = FeedCell.height()
        let difference: CGFloat = requiredHeight - contextHeight
        let height = contextHeight + difference
        
        
        return CGSize(width: width, height: height)
        
        
    }
    
    public func cellForItem(at index: Int) -> UICollectionViewCell {
        
        let cellClass: String = FeedCell.reuseIdentifier
        let cell = collectionContext!.dequeueReusableCell(withNibName: cellClass, bundle: Bundle.main, for: self, at: index)
        
        if let cell = cell as? FeedCell {
            
            cell.postImage.sd_setImage(with: URL(string: post.photoURL))
            cell.profileImage.sd_setImage(with: URL(string: post.profileURL))
            cell.usernameLabel.text = post.username
            cell.titleLabel.text = post.title
            cell.descriptionLabel.text = post.desc
            
        }
        
        return cell
    }
    
    public func didUpdate(to object: Any) {
        post = object as? Post
    }
    
    public func didSelectItem(at index: Int) {
        
    }
    
}
