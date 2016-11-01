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
        let id = SafeBrain().getIDForGuest()
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        var docs: String = paths[0] as! String
        let fullPath = docs + "/guest-\(id).jpg"
        var newID = Int(id)! + 1
        userDefaults.setObject("\(newID)", forKey: "guestPhotoID")
        print(fullPath)
        return imageData.writeToFile(fullPath, atomically: false)
        
    }
    
    
    
}
