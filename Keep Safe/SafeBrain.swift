//
//  SafeBrain.swift
//  Keep Safe
//
//  Created by Mert Serin on 01/11/2016.
//  Copyright © 2016 Mert Serin. All rights reserved.
//
import Foundation

class SafeBrain: NSCoder{
    
    var userDefaults = NSUserDefaults.standardUserDefaults()
        
    
    //MARK: registerUser ~ func for registering user to userDefaults
    func registerUser(email:String, password:String){
        
        userDefaults.setObject(email, forKey: "email")
        userDefaults.setObject(password, forKey: "password")
    }
    
    
    //MARK: getUser ~ func for getting object of SafeBrain
    func getUser() -> User{
        
        let email = userDefaults.objectForKey("email") as! String
        let password = userDefaults.objectForKey("password") as! String
        
        return User(email: email, password: password)
        
    }
    
    
    //MARK: checkForLogin ~ func for check password for Login step-1
    func checkForLogin(loginPassword:String)-> Bool{
        
        let userPassword = userDefaults.objectForKey("password") as! String
        
        if(loginPassword == userPassword){
            return true
        }
        else{
            return false
        }
    }
    
    
    
    func getIDForGuest() -> String{
        if let guestPhotoID = userDefaults.objectForKey("guestPhotoID") as? String{
            print("mert12")
            return guestPhotoID
        }
        else{
            print("mert13")
            userDefaults.setObject("0", forKey: "guestPhotoID")
            return "0"
        }
        
        
    }
    
    
    
    
}
