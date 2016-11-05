//
//  PhotoManager.swift
//  Keep Safe
//
//  Created by Mert Serin on 02/11/2016.
//  Copyright © 2016 Mert Serin. All rights reserved.
//

import Foundation

class PhotoManager{
    
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    //MARK: saveImageForUnplesantGuest
    func saveImageForUnplesantGuest(imageData:NSData) -> Bool{
        print(imageData)
        let id = SafeBrain().getIDForGuest()
        
        let fullPath = getPath() + "/guest-\(id).jpg"
        var newID = Int(id)! + 1
        userDefaults.setObject("\(newID)", forKey: "guestPhotoID")
        print(fullPath)
        return imageData.writeToFile(fullPath, atomically: false)
        
    }
    
    
    func saveImageForPhotos(imageData:NSData) -> Bool{
        
        let id = SafeBrain().getIDForPhotos()
        let fullPath = getPath() + "/photos-\(id).jpg"
        var newID = Int(id)! + 1
        userDefaults.setObject("\(newID)", forKey: "photoID")
        return imageData.writeToFile(fullPath, atomically: false)
        
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
            for(var i = 0; i < id; ++i){
                print("mert2")
                let fullPath = docs + "/photos-\(i).jpg"
                urlArray.append(fullPath)
            }
            return urlArray
        }
        else{
            print("asd1")
            let id = Int(SafeBrain().getIDForGuest())!
            for(var i = 0; i<id; ++i){
                print("asd")
               let fullPath = docs + "/guest-\(i).jpg"
                urlArray.append(fullPath)
            }
            return urlArray
        }
    }
    
    
    
    
    
}
