//
//  User.swift
//  Keep Safe
//
//  Created by Mert Serin on 02/11/2016.
//  Copyright © 2016 Mert Serin. All rights reserved.
//

import Foundation


class User{
    
    var email:String?
    var password:String?
    var userDefaults = NSUserDefaults.standardUserDefaults()
    
    
    init(email:String, password:String){
        self.email = email
        self.password = password
        
    }
    
    
    
    //MARK: setUserDefaults
    func setUserDefaults(){
        userDefaults.setObject(self.email!, forKey: "email")
        userDefaults.setObject(self.password!, forKey: "password")
    }
    

}
