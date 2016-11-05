//
//  FolderDetailCollectionViewCell.swift
//  Keep Safe
//
//  Created by Mert Serin on 03/11/2016.
//  Copyright © 2016 Mert Serin. All rights reserved.
//

import UIKit
import Haneke
class FolderDetailCollectionViewCell: UICollectionViewCell {
    
    var url:String?{
        didSet{
            loadDetails()
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    func loadDetails(){
        
        
        
        imageView.image = UIImage(contentsOfFile: url!)?.RBSquareImage()
        

        
    }
    
    func resizeImage(url:String, newWidth: CGFloat) -> UIImage {
        let image = UIImage(contentsOfFile: url)
        let scale = newWidth / image!.size.width
        let newHeight = image!.size.height * scale
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
        image!.drawInRect(CGRectMake(0, 0, newWidth, newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    
        return newImage!
    }
}


extension UIImage{
    func RBSquareImage() -> UIImage? {
        
        let originalWidth  = self.size.width
        let originalHeight = self.size.height
        
        var edge: CGFloat
        if originalWidth > originalHeight {
            edge = originalHeight
        } else {
            edge = originalWidth
        }
        
        let posX = (originalWidth  - edge) / 2.0
        let posY = (originalHeight - edge) / 2.0
        
        let cropSquare = CGRectMake(posX, posY, edge, edge)
        
        
        let imageRef = CGImageCreateWithImageInRect(self.CGImage!, cropSquare);
        return UIImage(CGImage: imageRef!, scale: UIScreen.mainScreen().scale, orientation: self.imageOrientation)
    }
}

