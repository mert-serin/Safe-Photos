//
//  PhotoManager.swift
//  Keep Safe
//
//  Created by Mert Serin on 02/11/2016.
//  Copyright © 2016 Mert Serin. All rights reserved.
//

import Foundation
import CoreData
import UIKit
class PhotoManager{
    
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    //MARK: saveImageForUnplesantGuest
    func saveImageForUnplesantGuest(imageData:NSData) -> Bool{

        let id = SafeBrain().getIDForGuest()
        
        let fullPath = getPath() + "/guest-\(id).jpg"
        var newID = Int(id)! + 1
        userDefaults.setObject("\(newID)", forKey: "guestPhotoID")
        if(imageData.writeToFile(fullPath, atomically: false)){
            if(saveData(Int(id)!, imageURL: fullPath, state: 1)){
                return true
            }
            else{
                return false
            }
        }
        else{
            return false
        }
        return false
        
    }
    
    
    func saveImageForPhotos(imageData:NSData) -> Bool{
        
        let id = SafeBrain().getIDForPhotos()
        let fullPath = getPath() + "/photos-\(id).jpg"
        var newID = Int(id)! + 1
        userDefaults.setObject("\(newID)", forKey: "photoID")
        if(imageData.writeToFile(fullPath, atomically: false)){
            if(saveData(Int(id)!, imageURL: fullPath, state: 0)){
                return true
            }
            else{
                return false
            }
        }
        else{
            return false
        }
        return false
    }
    
    func getPath() -> String{
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        var docs: String = paths[0] as! String
        return docs
    }
    
    
    //State == 0 ~ Saved Photos - State == 1 ~ Wrong Password
    func getImageFromDisk(state:Int) -> String{
        let docs = getPath()
        if(state == 0){
            let id = SafeBrain().getIDForPhotos()
            let fullPath = docs + "/photos-\(Int(id)!-1).jpg"
            return fullPath
        }
        else{
            let id = SafeBrain().getIDForGuest()
            let fullPath = docs + "/guest-\(Int(id)!-1).jpg"
            return fullPath
            
        }
        
    }
    
    //State == 0 ~ Saved Photos - State == 1 ~ Wrong Password
    func getPhotoURLArray(state:Int) -> [String]{
        let docs = getPath()
        var urlArray = [String]()
        if(state == 0){
            print("mert1")
            let id = Int(SafeBrain().getIDForPhotos())!
            for(var i = id-1; i >= 0; --i){
                print("mert2")
                let fullPath = docs + "/photos-\(i).jpg"
                urlArray.append(fullPath)
            }
            return urlArray
        }
        else{
            print("asd1")
            let id = Int(SafeBrain().getIDForGuest())!
            for(var i = id-1; i >= 0; --i){
                print("asd")
               let fullPath = docs + "/guest-\(i).jpg"
                urlArray.append(fullPath)
            }
            return urlArray
        }
    }
    
    
    func deletePhotoWithURL(imageID:Int,imageURL:String, state:Int)->Bool{
        
        let fileManager = NSFileManager.defaultManager()
        
        do {
            if(deleteData(imageID, state: state)){
                try fileManager.removeItemAtPath(imageURL)
                return true
            }
            else{
                return false
            }
            
            
        } catch let error as NSError {
            return false
        }
        
        return false
        
    }
    
    
    
    //Core Data
    
    
    func fetchCoreData(state:Int) -> [Photo]{
        var photoArray = [Photo]()
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        var fetchRequest = NSFetchRequest()
        
        if(state == 0){
            fetchRequest = NSFetchRequest(entityName: "SavedPhotos")
        }
        else{
            fetchRequest = NSFetchRequest(entityName: "PasswordPhotos")
        }
        
        
        
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            for photo in results{
                
                let imageURL = photo.valueForKey("imageURL") as! String
                let imageID = photo.valueForKey("imageID") as! Int
                
                let photo = Photo(imageID: imageID, imageURL: imageURL)
                
                photoArray.append(photo)
                
            }
            
            return photoArray
        } catch let error as NSError {
            return []
        }
    }
    
    
    
    func fetchLastPhotoObj(state:Int) -> Photo?{
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        var fetchRequest = NSFetchRequest()
        
        if(state == 0){
            fetchRequest = NSFetchRequest(entityName: "SavedPhotos")
        }
        else{
            fetchRequest = NSFetchRequest(entityName: "PasswordPhotos")
        }
        
        
        
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            
            if let photo = results.last{
                let imageURL = photo.valueForKey("imageURL") as! String
                let imageID = photo.valueForKey("imageID") as! Int
                
                return Photo(imageID: imageID, imageURL: imageURL)
            }
            
            
        } catch let error as NSError {
            return nil
        }
        
        return nil
    }
    
    
    
    

    
    func saveData(imageID:Int, imageURL: String, state:Int) -> Bool{
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        var entity:NSEntityDescription?
        
        if(state == 0){
            entity =  NSEntityDescription.entityForName("SavedPhotos",
                                                        inManagedObjectContext:managedContext)
        }
        else{
            entity =  NSEntityDescription.entityForName("PasswordPhotos",
                                                        inManagedObjectContext:managedContext)
        }
        
        
        
        let feed = NSManagedObject(entity: entity!,
                                   insertIntoManagedObjectContext: managedContext)
        
        
        feed.setValue(imageID, forKey: "imageID")
        feed.setValue(imageURL, forKey: "imageURL")

        
        do {
            try managedContext.save()
            
            return true
        } catch let error as NSError  {
            
            return false
        }
        
    }
    

    
    
    func deleteData(imageID:Int, state:Int)->Bool{
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        var fetchRequest = NSFetchRequest()
        if(state == 0){
            fetchRequest = NSFetchRequest(entityName: "SavedPhotos")
        }
        else{
            fetchRequest = NSFetchRequest(entityName: "PasswordPhotos")
        }
        
        
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest) as! [NSManagedObject]
            
            for(var i = 0; i<results.count; ++i){
                let photoItem: NSManagedObject = results[i]
                let objImgID = photoItem.valueForKey("imageID") as! Int
                if(objImgID == imageID){
                    managedContext.deleteObject(photoItem)
                    do{
                        try managedContext.save()
                        return true
                    }
                    catch let error as NSError{
                        
                        return false
                    }
                    
                }
            }
            
        } catch let error as NSError {
            return false
        }
        
        return true
        
    }

    
    
    
    
}
