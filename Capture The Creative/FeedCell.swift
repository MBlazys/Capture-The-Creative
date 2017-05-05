//
//  FeedCell.swift
//  Capture The Creative
//
//  Created by Martynas Blazys on 04/05/2017.
//  Copyright © 2017 Martynas Blazys. All rights reserved.
//

import UIKit
import Reusable

class FeedCell: UICollectionViewCell, NibReusable {

    @IBOutlet var profileImage: UIImageView!
    
    @IBOutlet var postImage: UIImageView!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UITextView!
    
    static func height() -> CGFloat {
        return 580.0
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2
        self.postImage.layer.cornerRadius = 5
        
    }

}
