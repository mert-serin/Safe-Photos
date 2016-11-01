//
//  Landing1VCViewController.swift
//  Keep Safe
//
//  Created by Mert Serin on 01/11/2016.
//  Copyright © 2016 Mert Serin. All rights reserved.
//

import UIKit

class Landing1VC: UIViewController {


    
    
    @IBAction private func nextButtonAction() {
        
        NSNotificationCenter.defaultCenter().postNotificationName("showLanding1", object: nil)
    }
    
    
}
