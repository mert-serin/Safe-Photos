//
//  AlbumCollectionViewCell.swift
//  Keep Safe
//
//  Created by Mert Serin on 05/11/2016.
//  Copyright © 2016 Mert Serin. All rights reserved.
//

import UIKit
import Photos
import Haneke

class AlbumCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    
    
    var album:AlbumModel?{
        didSet{

            
            if(album?.name == "Photo Roll"){
                loadPhotoRoll()
            }
            else{
                loadDetails()
            }
        }
    }
    
    
    func loadPhotoRoll(){
        
        imageView.image = nil
        var photoAssets = PHFetchResult()
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "modificationDate",
            ascending: false)]
        
        photoAssets = PHAsset.fetchAssetsWithMediaType(.Image, options: fetchOptions)
        
        
        
        let imageManager = PHImageManager.defaultManager()
        
        
        for(var i = 0; i<photoAssets.count; ++i){
            var asset = photoAssets[i] as! PHAsset
            
            var imageSize = CGSize()
            
            if(asset.pixelWidth > 1000 || asset.pixelHeight > 1000){
                imageSize = CGSize(width: 200,height: 200)
            }
            else{
                imageSize = CGSize(width: asset.pixelWidth, height: asset.pixelHeight)
            }
            
            
            
            let options = PHImageRequestOptions()
            options.deliveryMode = .FastFormat
            options.synchronous = true
            
            imageManager.requestImageForAsset(asset,
                                              targetSize: imageSize,
                                              contentMode: .AspectFill,
                                              options: options,
                                              resultHandler: {
                                                (image, info) -> Void in
                                                
                                                print(image!.RBSquareImage()!)
                                                self.imageView.hnk_setImage(image!.RBSquareImage()!, animated: true, success: nil)
                                                
                                                
                                                
            })
            break;
        }
        albumNameLabel.text = album?.name
    }
    
    
    
    func loadDetails(){
        imageView.image = nil
        
        var albumName = album?.name
        var assetCollection = PHAssetCollection()
        var albumFound = Bool()
        var photoAssets = PHFetchResult()
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "title = %@", albumName!)
        let collection:PHFetchResult = PHAssetCollection.fetchAssetCollectionsWithType(.Album, subtype: .Any, options: fetchOptions)
        
        if let first_Obj:AnyObject = collection.firstObject{
            //found the album
            assetCollection = collection.firstObject as! PHAssetCollection
            albumFound = true
        }
        else { albumFound = false }
        var i = collection.count
        photoAssets = PHAsset.fetchAssetsInAssetCollection(assetCollection, options: nil)
        let imageManager = PHCachingImageManager()
        
        //        let imageManager = PHImageManager.defaultManager()
        
        
        for(var i = 0; i<photoAssets.count; ++i){
            var asset = photoAssets[i] as! PHAsset
            
            /* For faster performance, and maybe degraded image */
            let options = PHImageRequestOptions()
            options.deliveryMode = .Opportunistic
            
            var imageSize = CGSize()
            
            if(asset.pixelWidth > 1000 || asset.pixelHeight > 1000){
                print("girdim")
                imageSize = CGSize(width: 1000,height: 1000)
            }
            else{
                
                imageSize = CGSize(width: asset.pixelWidth, height: asset.pixelHeight)
            }
            
            print("Height \(PHImageManagerMaximumSize.height) \(PHImageManagerMaximumSize.width)")
            
            imageManager.requestImageForAsset(asset,
                                              targetSize: imageSize,
                                              contentMode: .AspectFill,
                                              options: options,
                                              resultHandler: {
                                                (image, info) -> Void in
                                                if let newImage = image{
                                                    self.imageView.image = newImage.RBSquareImage()
                                                }
                                                
                                                
                                                
            })
            break;
        }
        albumNameLabel.text = album?.name
    }
    
    
}
