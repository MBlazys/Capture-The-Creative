//
//  FeedViewController.swift
//  Capture The Creative
//
//  Created by Martynas Blazys on 28/04/2017.
//  Copyright © 2017 Martynas Blazys. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage
import IGListKit

class FeedViewController: UIViewController {
    
    var databaseRef: FIRDatabaseReference!
    
    @IBOutlet var collectionView: IGListCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        databaseRef = FIRDatabase.database().reference()

    }

}
