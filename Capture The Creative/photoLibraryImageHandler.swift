//
//  photoLibraryImageHandler.swift
//  Capture The Creative
//
//  Created by Martynas Blazys on 16/03/2017.
//  Copyright © 2017 Martynas Blazys. All rights reserved.
//

import UIKit
import Photos

extension CameraVC {
    
    func retrieveLastImageFromPhotoLibrary() {
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        
        let fetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        
        let last = fetchResult.lastObject
        
        if let lastAsset = last {
            let options = PHImageRequestOptions()
            options.version = .current
            
            PHImageManager.default().requestImage(
                for: lastAsset,
                targetSize: photoLibraryImage.bounds.size,
                contentMode: .aspectFill,
                options: options,
                resultHandler: { image, _ in
                    DispatchQueue.main.async {
                        self.photoLibraryImage.image = image
                    }
            }
            )
        }
        
    }
}
