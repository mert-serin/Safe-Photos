//
//  PhotoDetailVC.swift
//  Keep Safe
//
//  Created by Mert Serin on 05/11/2016.
//  Copyright © 2016 Mert Serin. All rights reserved.
//

import UIKit
import Haneke
import KVNProgress
class PhotoDetailVC: UIViewController {
    
    
    
    @IBOutlet weak var imageView: UIImageView!
    var photoObj:Photo?
    var state = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPhoto()
        
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        //Hide Bottom Bar
        NSNotificationCenter.defaultCenter().postNotificationName("hideBottomBar", object: nil)
    }
    
    
    
    override func viewWillDisappear(animated: Bool) {
        //Show Bottom Bar Again
        NSNotificationCenter.defaultCenter().postNotificationName("showBottomBar", object: nil)

    }

    
    
    func loadPhoto(){
        self.imageView.image = UIImage(contentsOfFile: (photoObj?.imageURL)!)
    }
    
    
    @IBAction func backButtonAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    

    
    @IBAction func deleteShareAction(sender: AnyObject) {
        
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .ActionSheet)
        
        // 2
        let deleteAction = UIAlertAction(title: "Delete", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            
            self.deleteAction()
            
        })
        let shareAction = UIAlertAction(title: "Share", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            
            self.shareAction()
            
        })
        
        //
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            
        })
        
        
        // 4
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(shareAction)
        optionMenu.addAction(cancelAction)
        
        // 5
        self.presentViewController(optionMenu, animated: true, completion: nil)
        
    }
    
    
    func shareAction(){
        // image to share
        let objectsToShare = [self.imageView.image!]
        
        
        
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVC.excludedActivityTypes = [UIActivityTypeOpenInIBooks, UIActivityTypePostToWeibo, UIActivityTypeAssignToContact, UIActivityTypePrint, UIActivityTypeAddToReadingList]
        self.presentViewController(activityVC, animated: true, completion: nil)
    }
    
    func deleteAction(){
        
        KVNProgress.show()
        if(PhotoManager().deletePhotoWithURL((photoObj?.imageID)!, imageURL: (photoObj?.imageURL)!, state:state)){
            KVNProgress.showSuccessWithStatus("Image deleted successfully", completion: {
                self.navigationController?.popViewControllerAnimated(true)
            })
        }
        else{
            print("bir sorun oldu")
            KVNProgress.dismiss()
        }
        
    }
    


}
