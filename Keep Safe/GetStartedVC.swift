//
//  GetStartedVC.swift
//  Keep Safe
//
//  Created by Mert Serin on 01/11/2016.
//  Copyright © 2016 Mert Serin. All rights reserved.
//

import UIKit

class GetStartedVC: UIViewController {

   
    
    
    @IBAction func getStartedAction() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("loginVC") as! LoginVC
        self.presentViewController(vc, animated: true, completion: nil)
        
        
    }
    

}
