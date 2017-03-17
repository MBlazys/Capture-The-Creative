//
//  PostVC.swift
//  Capture The Creative
//
//  Created by Martynas Blazys on 16/03/2017.
//  Copyright © 2017 Martynas Blazys. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Firebase

class PostVC: UIViewController, UITextViewDelegate, UITextFieldDelegate {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var descriptionTextView: UITextView!
    
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // IQKeyboardManager settings
        IQKeyboardManager.sharedManager().enableAutoToolbar = false
        IQKeyboardManager.sharedManager().shouldResignOnTouchOutside = true

        titleTextField.delegate = self
        descriptionTextView.delegate = self
        imageView.image = image
        
        // Description text view placeholder
        descriptionTextView.text = "Express yourself..."
        descriptionTextView.textColor = UIColor.lightGray
        
    }
    
    @IBAction func handlePostButton(_ sender: Any) {
        
        uploadPost()
        
    }

    // Hide status bar e.g. Time, Battery Life
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Express yourself..."
            textView.textColor = UIColor.lightGray
        }
    }
    
}
