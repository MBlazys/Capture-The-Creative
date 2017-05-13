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
import Social
import MapKit
import CoreLocation

class PostVC: UIViewController, UITextViewDelegate, UITextFieldDelegate, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var facebookSwitch: UISwitch!
    @IBOutlet var twitterSwitch: UISwitch!
    
    var image: UIImage?
    
    // Outlets and variables for MapKit
    @IBOutlet var map: MKMapView!
    var latitude: String!
    var longitude: String!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MapKit: set map settings
        map.delegate = self
        map.mapType = .standard
        map.isZoomEnabled = true
        map.isScrollEnabled = true
        
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
    
    override func viewWillDisappear(_ animated: Bool) {
        map.showsUserLocation = false
    }
    
    @IBAction func handlePostButton(_ sender: Any) {
        
        uploadPost()
    }
    
    @IBAction func handleCancelButton(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
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
    
    // Social media switch buttons
    @IBAction func handleFacebookSharing(_ sender: UISwitch) {
        
        if (sender.isOn == true) {
            
            facebookShare() 
        }
    }
    
    @IBAction func handleTwitterSharing(_ sender: UISwitch) {
        
        if (sender.isOn == true) {
            
            twitterShare()
        }
    }
    
    // Add location switch
    @IBAction func handleLocationSharing(_ sender: UISwitch) {
        
        if (sender.isOn == true) {
    
            // MapKit: asks user for authorisation to use location
            self.locationManager.requestAlwaysAuthorization()
            self.locationManager.requestWhenInUseAuthorization()
            
            if CLLocationManager.locationServicesEnabled() {
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.startUpdatingLocation()
            }
            
            map.showsUserLocation = true
            
        }
        
        if (sender.isOn == false) {
            
            locationManager.stopUpdatingLocation()
            map.showsUserLocation = false
            latitude = ""
            longitude = ""
            print(latitude)
            print(longitude)
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        manager.stopUpdatingLocation()
        
        let myLocation = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude,longitude: userLocation.coordinate.longitude)
        let span = MKCoordinateSpanMake(0.2,0.2)
        let region = MKCoordinateRegion(center: myLocation, span: span)
        
        map.setRegion(region, animated: true)
        
        let location = manager.location!.coordinate
        
        latitude = String(location.latitude)
        longitude = String(location.longitude)
        
        print(latitude)
        print(longitude)
    
    }
    
    // Hide status bar e.g. Time, Battery Life
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
