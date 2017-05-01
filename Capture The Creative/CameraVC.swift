//
//  CameraVC.swift
//  Capture The Creative
//
//  Created by Martynas Blazys on 14/03/2017.
//  Copyright © 2017 Martynas Blazys. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

class CameraVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var cameraButton: UIButton!
    @IBOutlet var photoLibraryImage: UIImageView!
    
    let captureSession = AVCaptureSession()
    
    var backFacingCamera: AVCaptureDevice?
    var frontFacingCamera: AVCaptureDevice?
    var currentDevice: AVCaptureDevice?
    
    var stillImageOutput: AVCaptureStillImageOutput?
    var stillImage: UIImage?
    
    var cameraPreviewLayer:AVCaptureVideoPreviewLayer?
    var toggleCameraGestureRecognizer = UITapGestureRecognizer()
    
    var zoomInGestureRecognizer = UISwipeGestureRecognizer()
    var zoomOutGestureRecognizer = UISwipeGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = true
        
        // Get the last image from the library to show up
        retrieveLastImageFromPhotoLibrary()
        
        // Apply CameraVC Outlet settings
        photoLibraryImage.layer.cornerRadius = 10
        photoLibraryImage.isUserInteractionEnabled = true
        
        
        // Setup camera
        cameraSetup()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.photoLibraryImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlePickImageFromLibrary)))
    }
    
    
    
    @IBAction func capture(_ sender: Any) {
        let videoConnection = stillImageOutput?.connection(withMediaType: AVMediaTypeVideo)
        stillImageOutput?.captureStillImageAsynchronously(from: videoConnection, completionHandler: { (imageDataSampleBuffer, error) -> Void in
            
            if let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataSampleBuffer) {
                self.stillImage = UIImage(data: imageData)
                self.performSegue(withIdentifier: "showPhoto", sender: self)
                
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "showPhoto" {
            let photoViewController = segue.destination as! UINavigationController
            let targetController = photoViewController.topViewController as! PhotoVC
            targetController.image = stillImage
        }
    }
    
    // Hide status bar e.g. Time, Battery Life
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
