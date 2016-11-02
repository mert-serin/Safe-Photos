//
//  MainVC.swift
//  Keep Safe
//
//  Created by Mert Serin on 03/11/2016.
//  Copyright © 2016 Mert Serin. All rights reserved.
//

import UIKit

class MainVC: UIViewController,UIScrollViewDelegate {
    
    
    @IBOutlet weak var menuSV: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()

        menuSV.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    //MARK: folderButtonAction ~ ScrollView Content 1
    @IBAction private func folderButtonAction(sender: UIButton) {
        
        
    }
    
    //MARK: cameraButtonAction ~ Show Camera
    @IBAction private func cameraButtonAction(sender: UIButton) {
        
        
    }
    
    //MARK: settingsButtonAction ~ ScrollView Content 2
    @IBAction private func settingsButtonAction(sender: UIButton) {
    
        
    }
    




}
