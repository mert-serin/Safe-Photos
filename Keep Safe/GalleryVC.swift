//
//  GalleryVC.swift
//  Keep Safe
//
//  Created by Mert Serin on 05/11/2016.
//  Copyright © 2016 Mert Serin. All rights reserved.
//

import UIKit
import Photos

class GalleryVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var photoArray = [PHAsset]()
    var isPhotoRoll = false
    var albumName = ""
    var index = 0
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        

        
        
        navigationController?.interactivePopGestureRecognizer!.delegate = self
        
        if(isPhotoRoll == false){
            loadDetails()
        }
        else{
            loadPhotoRoll(0)
        }
        

        
    }
    

    
    
    
    @IBAction func showCameraAction(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName("showCamera", object: nil)
    }
    
    
    
    
    func loadPhotoRoll(page:Int){
        
        
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate",
            ascending: false)]
        
        
        
        let assetResults = PHAsset.fetchAssetsWithMediaType(.Image, options: fetchOptions)
        for(var i = 0; i<assetResults.count; ++i){
            photoArray.append(assetResults[i] as! PHAsset)
        }
        collectionView.reloadData()
        
    }
    
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func smallBackButtonAction() {
        
        largeBackButtonAction()
    }
    
    @IBAction func largeBackButtonAction() {
        
        navigationController?.popViewControllerAnimated(true)
    }
    
    
    func loadDetails(){
        
        
        var assetCollection = PHAssetCollection()
        var albumFound = Bool()
        var photoAssets = PHFetchResult()
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "title = %@", albumName)
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
        
        
        
        for(var i = 0; i<photoAssets.count; ++i){
            var asset = photoAssets[i] as! PHAsset
            photoArray.append(asset)
        }
        
        collectionView.reloadData()
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        index = indexPath.row
        performSegueWithIdentifier("showGalleryImageSegue", sender: nil)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "showGalleryImageSegue"){
            let vc = segue.destinationViewController as! GalleryImageDetailVC
            vc.imageAsset = photoArray[index]
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let frame = collectionView.frame
        let width = frame.width
        let height = frame.height
        
        return CGSizeMake(width / 3 - 4, width / 3 - 4)
    }
    
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! GalleryCollectionViewCell
        cell.media = photoArray[indexPath.row]
        return cell
        
        
        
    }
    
    
    @IBAction func backButtonAction(sender: AnyObject) {
        
        self.navigationController?.popViewControllerAnimated(true)
        
    
    }


}
