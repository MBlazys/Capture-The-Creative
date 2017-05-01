//
//  UserCell.swift
//  Capture The Creative
//
//  Created by Martynas Blazys on 30/04/2017.
//  Copyright © 2017 Martynas Blazys. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var usernameTextField: UILabel!
    @IBOutlet var fullnameTextField: UILabel!
    
    var userID: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Settings for profile image
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2
        self.profileImage.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
