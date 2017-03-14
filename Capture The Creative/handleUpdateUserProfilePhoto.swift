//
//  handleUpdateUserProfilePhoto.swift
//  Capture The Creative
//
//  Created by Martynas Blazys on 10/03/2017.
//  Copyright © 2017 Martynas Blazys. All rights reserved.
//

import UIKit

extension EditProfileVC {
    
    func handleSelectProfileImageFromLibrary() {
        let imagePicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker{
            profileImage.image = selectedImage
            self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2
            self.profileImage.layer.borderWidth = 1
            self.profileImage.layer.borderColor = UIColor.black.cgColor
            self.profileImage.clipsToBounds = true
        }
        
        if (selectedImageFromPicker != nil) {
            self.dismiss(animated: true, completion: nil) // dismisses Photo Library when image is selected
            
        }
    }
    
}
