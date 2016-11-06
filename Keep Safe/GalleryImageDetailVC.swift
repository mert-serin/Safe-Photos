//
//  GalleryImageDetailVC.swift
//  Keep Safe
//
//  Created by Mert Serin on 05/11/2016.
//  Copyright © 2016 Mert Serin. All rights reserved.
//

import UIKit
import Photos
import KVNProgress
class GalleryImageDetailVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var imageAsset:PHAsset?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        
        
        let imageManager = PHCachingImageManager()
        var divide = 1
        if(imageAsset?.pixelWidth > 4000 || imageAsset?.pixelHeight > 4000){
            divide = 4
        }
        else if((imageAsset?.pixelWidth > 2500 && imageAsset?.pixelWidth < 4000) || (imageAsset?.pixelHeight > 2500 && imageAsset?.pixelHeight < 4000)) {
            divide = 3
        }
        
        
        let imageSize = CGSize(width: imageAsset!.pixelWidth/divide,
                               height: imageAsset!.pixelHeight/divide)
        let options = PHImageRequestOptions()
        options.deliveryMode = .HighQualityFormat
        options.synchronous = true
        options.resizeMode = .Fast
        
        imageManager.requestImageForAsset(imageAsset!,
                                          targetSize: imageSize,
                                          contentMode: PHImageContentMode.AspectFit,
                                          options: options,
                                          resultHandler: {(image: UIImage?,
                                            info: [NSObject : AnyObject]?) in
                                            
                                            self.imageView.image = image
                                            
                                            
                                            
        })
        
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        //Hide Bottom Bar
        NSNotificationCenter.defaultCenter().postNotificationName("hideBottomBar", object: nil)
    }
    
    
    
    override func viewWillDisappear(animated: Bool) {
        //Show Bottom Bar Again
        NSNotificationCenter.defaultCenter().postNotificationName("showBottomBar", object: nil)
        
    }

    @IBAction func backButtonAction(sender: AnyObject) {
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    
    @IBAction func saveButtonAction(sender: AnyObject) {
        let enumeration: NSArray = [imageAsset!]
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            if(PhotoManager().saveImageForPhotos(UIImageJPEGRepresentation(self.imageView.image!, 0.8)!)){
                PHPhotoLibrary.sharedPhotoLibrary().performChanges( {
                    
                    PHAssetChangeRequest.deleteAssets(enumeration)
                    
                    
                    },completionHandler: { success, error in
                        if(success){
                            dispatch_async(dispatch_get_main_queue()) {
                                
                                if let views = self.navigationController?.viewControllers{
                                    let count = views.count
                                    self.navigationController?.popToViewController(views[count-4], animated: true)
                                }
                                
                                
                            }
                            
                            
                        }
                })
            }
            else{
                
            }

            
        }
       
    }


    


}
