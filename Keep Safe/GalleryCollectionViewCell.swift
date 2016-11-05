//
//  GalleryCollectionViewCell.swift
//  Keep Safe
//
//  Created by Mert Serin on 05/11/2016.
//  Copyright © 2016 Mert Serin. All rights reserved.
//


import UIKit
import Photos
import Haneke
class GalleryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    var media:PHAsset?{
        didSet{
            loadPhoto()
        }
    }
    
    
    func loadPhoto(){
        
        imageView.image = nil
        
        let imageManager = PHCachingImageManager()
        let imageSize = CGSize(width: 200,
                               height: 200)
        let options = PHImageRequestOptions()
        options.deliveryMode = .FastFormat
        options.synchronous = true
        options.resizeMode = .Fast
        
        imageManager.requestImageForAsset(media!,
                                          targetSize: imageSize,
                                          contentMode: .AspectFill,
                                          options: options,
                                          resultHandler: {(image: UIImage?,
                                            info: [NSObject : AnyObject]?) in
                                            
                                            self.imageView.image = image?.RBSquareImage()
                                            
        })
    }
    
}
