//
//  FolderDetailVC.swift
//  Keep Safe
//
//  Created by Mert Serin on 03/11/2016.
//  Copyright © 2016 Mert Serin. All rights reserved.
//

import UIKit

class FolderDetailVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIGestureRecognizerDelegate{

    @IBOutlet weak var navBlurView: UIVisualEffectView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var folderName: UILabel!
    
    
    @IBOutlet weak var largePlusOutlet: UIButton!
    @IBOutlet weak var plusOutlet: UIButton!
    
    var state = 0
    var index = 0
    
    var photoURLArray = [Photo]()
    
    var isDeleteState = false
    
    var longPress:UILongPressGestureRecognizer?
    var tapGesture:UITapGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(state == 0){
            folderName.text = "Photos"
        }
        else{
            largePlusOutlet.hidden = true
            plusOutlet.hidden = true
        }
        collectionView.delegate = self
        collectionView.dataSource = self

        navBlurView.layer.shadowColor = UIColor.blackColor().colorWithAlphaComponent(1).CGColor
        navBlurView.layer.shadowOffset = CGSize(width: 0, height: 0)
        navBlurView.layer.shadowOpacity = 1
        
        
        longPress = UILongPressGestureRecognizer(target: self, action: "handleLongPress:")
        longPress!.minimumPressDuration = 1
        longPress!.delegate = self
        longPress!.delaysTouchesBegan = true
        self.collectionView?.addGestureRecognizer(longPress!)
        
        
    }
    
    func handleLongPress(gestureRecognizer : UILongPressGestureRecognizer){
        
        
        if(isDeleteState == false){
            
            
            if (gestureRecognizer.state != UIGestureRecognizerState.Ended){
                return
            }
            
            let p = gestureRecognizer.locationInView(self.collectionView)
            
            if let indexPath : NSIndexPath = (self.collectionView?.indexPathForItemAtPoint(p))!{
                print(indexPath.row)
            }
            
            isDeleteState = true
            
            self.collectionView.removeGestureRecognizer(longPress!)
            
            tapGesture = UITapGestureRecognizer(target: self, action: "handleTapGesture:")
            tapGesture!.numberOfTapsRequired = 1
            self.collectionView.addGestureRecognizer(tapGesture!)
            
            
            
        }
        
    }
    
    func handleTapGesture(gestureRecognizer : UILongPressGestureRecognizer){
        
        
        if(isDeleteState == true){
            
            
            if (gestureRecognizer.state != UIGestureRecognizerState.Ended){
                return
            }
            
            let p = gestureRecognizer.locationInView(self.collectionView)
            
            if let indexPath : NSIndexPath = (self.collectionView?.indexPathForItemAtPoint(p)){
                print(indexPath.row)
            }
            
            
            
            
            
            
            
        }
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        photoURLArray = []
        photoURLArray = PhotoManager().fetchCoreData(state)
        collectionView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "showPhotoDetailSegue"){
            let vc = segue.destinationViewController as! PhotoDetailVC
            vc.photoObj = photoURLArray[index]
            vc.state = state
        }
    }
    
    
    
    
    @IBAction func backButtonAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    //MARK: Show Gallery
    @IBAction func plusButtonAction(sender: AnyObject) {
        
        
        
    }
    

    
    
    

}

extension FolderDetailVC{
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoURLArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        

        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! FolderDetailCollectionViewCell
        
        cell.url = photoURLArray[indexPath.row].imageURL!
        
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print(photoURLArray[indexPath.row].imageURL)
        self.index = indexPath.row
        performSegueWithIdentifier("showPhotoDetailSegue", sender: nil)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let frame = collectionView.frame
        let width = frame.width
        let height = frame.height
        
        return CGSizeMake(width / 3 - 4, width / 3 - 4)
    }
}
