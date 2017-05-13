//
//  handleSocialSharing.swift
//  Capture The Creative
//
//  Created by Martynas Blazys on 05/05/2017.
//  Copyright © 2017 Martynas Blazys. All rights reserved.
//

import UIKit
import Social
import Firebase

extension PostVC {
    
    func facebookShare() {
        
        guard SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook) else {
            let alert = UIAlertController(title: "Facebook Unavailable", message: "You haven't registered your Facebook account. Please go to Settings -> Facebook to create one.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            self.facebookSwitch.setOn(false, animated: true)
            
            return
        }
        
        // Display Facebook share
        if let facebookComposer = SLComposeViewController(forServiceType: SLServiceTypeFacebook) {
            
            // Retrieves the description written by the user to post on facebook
            facebookComposer.setInitialText(descriptionTextView.text)
            
            // Retrieves the image taken or chosen to post on facebook
            facebookComposer.add(imageView.image)
            
            // If canceled is pressed on Facebook share view... reset the switch
            facebookComposer.completionHandler = {(_ result: SLComposeViewControllerResult) -> Void in
                
                if result == .cancelled {
                    
                    self.facebookSwitch.setOn(false, animated: true)
                }
            }
            
            self.present(facebookComposer, animated: true, completion: nil)
        }
    }
    
    func twitterShare() {
        
        guard SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) else {
            
            let alert = UIAlertController(title: "Twitter Unavailable", message: "You haven't registered your Twitter account. Please go to Settings -> Twitter to create one.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            self.twitterSwitch.setOn(false, animated: true)
            
            return
        }
        
        // Display Twitter share
        if let twitterComposer = SLComposeViewController(forServiceType: SLServiceTypeTwitter) {
            
            // Retrieves the description written by the user to post on facebook
            twitterComposer.setInitialText(descriptionTextView.text)
            
            // Retrieves the image taken or chosen to post on facebook
            twitterComposer.add(imageView.image)
            
            // If canceled is pressed on Facebook share view... reset the switch
            twitterComposer.completionHandler = {(_ result: SLComposeViewControllerResult) -> Void in
                
                if result == .cancelled {
                    
                    self.twitterSwitch.setOn(false, animated: true)
                }
            }
            
            self.present(twitterComposer, animated: true, completion: nil)
        }
    }
}
