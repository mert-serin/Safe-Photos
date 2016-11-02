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
    
    func getPath() -> String{
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        var docs: String = paths[0] as! String
        return docs
    }
    
    
    //State == 0 ~ Saved Photos - State == 1 ~ Wrong Password
    func getImageFromDisk(state:Int) -> String{
        let docs = getPath()
        if(state == 0){
            let id = SafeBrain().getIDForGuest()
            let fullPath = docs + "/photos-\(id).jpg"
            return fullPath
        }
        else{
            let id = SafeBrain().getIDForGuest()
            let fullPath = docs + "/guest-\(Int(id)!-1).jpg"
            return fullPath
            
        }
        
    }
    
    
    
}
