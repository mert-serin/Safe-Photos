//
//  AlbumVC.swift
//  Keep Safe
//
//  Created by Mert Serin on 05/11/2016.
//  Copyright © 2016 Mert Serin. All rights reserved.
//

import UIKit
import Photos
class AlbumVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var albumArray = [AlbumModel]()
    var index = 0
    var refresher:UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        collectionView.dataSource = self
        collectionView.delegate = self
        
        

        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        if(albumArray.isEmpty){
            if(PHPhotoLibrary.authorizationStatus().rawValue == 0){
                PHPhotoLibrary.requestAuthorization({(permission)->Void in
                    
                    if(permission.rawValue == 2){
                        
                    }
                    else if(permission.rawValue == 3){
                        
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                            self.listAlbums()
                            dispatch_async(dispatch_get_main_queue()) {
                                self.collectionView.reloadData()
                                
                            }
                            
                            
                        }
                        
                        
                    }
                })
            }
            else if(PHPhotoLibrary.authorizationStatus().rawValue == 2){
                
            }else if(PHPhotoLibrary.authorizationStatus().rawValue == 3){
                
                self.listAlbums()
                
                
            }
        }
        
    }

    

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func listAlbums() {
        
        albumArray = []
        
        let photoRoll = AlbumModel(name: "Photo Roll", count: 0, collection: PHAssetCollection.init())
        self.albumArray.append(photoRoll)
        
        
        let options = PHFetchOptions()
        let userAlbums = PHAssetCollection.fetchAssetCollectionsWithType(PHAssetCollectionType.Album, subtype: PHAssetCollectionSubtype.Any, options: options)
        userAlbums.enumerateObjectsUsingBlock{ (object: AnyObject!, count: Int, stop: UnsafeMutablePointer) in
            if object is PHAssetCollection {
                let obj:PHAssetCollection = object as! PHAssetCollection
                
                let fetchOptions = PHFetchOptions()
                fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
                fetchOptions.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.Image.rawValue)
                
                if(obj.estimatedAssetCount > 0){
                    let newAlbum = AlbumModel(name: obj.localizedTitle!, count: obj.estimatedAssetCount, collection:obj)
                    self.albumArray.append(newAlbum)
                }
            }
        }
        
        self.collectionView.reloadData()
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "showGallerySegue"){
            let vc = segue.destinationViewController as! GalleryVC
            vc.albumName = albumArray[index].name
            if(index == 0){
                vc.isPhotoRoll = true
            }
        }
    }
    
    @IBAction func backButtonAction(sender: AnyObject) {
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    

}



class AlbumModel {
    
    let name:String
    let count:Int
    let collection:PHAssetCollection?
    init(name:String, count:Int, collection:PHAssetCollection) {
        self.name = name
        self.count = count
        self.collection = collection
    }
}

//Collection View functions is all here
extension AlbumVC{
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! AlbumCollectionViewCell
        cell.album = albumArray[indexPath.row]
        cell.contentView.layer.masksToBounds = true
        cell.contentView.layer.cornerRadius = 10
        return cell
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        index = indexPath.row
        performSegueWithIdentifier("showGallerySegue", sender: nil)
    }
    
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let frame = collectionView.frame
        let width = frame.width
        let height = frame.height
        
        return CGSizeMake(width / 2 - 20, height / 3 - 10)
        
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albumArray.count
    }
    
}
