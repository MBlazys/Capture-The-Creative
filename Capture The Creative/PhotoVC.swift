//
//  PhotoVC.swift
//  Capture The Creative
//
//  Created by Martynas Blazys on 15/03/2017.
//  Copyright © 2017 Martynas Blazys. All rights reserved.
//

import UIKit

class PhotoVC: UIViewController {

    @IBOutlet var imageView: UIImageView!
    var image: UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = image

    }
    
    @IBAction func handleCancelButton(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        
        self.performSegue(withIdentifier: "showPost", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showPost" {
            let postViewController = segue.destination as! UINavigationController
            let targetController = postViewController.topViewController as! PostVC
            targetController.image = imageView.image
        }
        
    }
    
    
    // Hide status bar e.g. Time, Battery Life
    override var prefersStatusBarHidden: Bool {
        return true
    }

}
