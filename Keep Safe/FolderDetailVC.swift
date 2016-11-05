//
//  FolderDetailVC.swift
//  Keep Safe
//
//  Created by Mert Serin on 03/11/2016.
//  Copyright © 2016 Mert Serin. All rights reserved.
//

import UIKit

class FolderDetailVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var navBlurView: UIVisualEffectView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var state = 0
    var index = 0
    
    var photoURLArray = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self

        navBlurView.layer.shadowColor = UIColor.blackColor().colorWithAlphaComponent(1).CGColor
        navBlurView.layer.shadowOffset = CGSize(width: 0, height: 0)
        navBlurView.layer.shadowOpacity = 1
        
        photoURLArray = PhotoManager().getPhotoURLArray(state)
        print(photoURLArray.count)
        collectionView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    
    @IBAction func backButtonAction() {
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "showPhotoDetailSegue"){
            let vc = segue.destinationViewController as! PhotoDetailVC
            print(photoURLArray[index])
            vc.url = photoURLArray[index]
        }
    }
    
    
    
    

    
    

}

extension FolderDetailVC{
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoURLArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! FolderDetailCollectionViewCell
        
        cell.url = photoURLArray[indexPath.row]
        
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
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
