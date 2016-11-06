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
    @IBOutlet weak var bottomBarView: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        menuSV.delegate = self
        
        //Initialize using Unique ID for the View
        let V1 = self.storyboard?.instantiateViewControllerWithIdentifier("mNVC1")
        //Add initialized view to main view and its scroll view also set bounds
        self.addChildViewController(V1!)
        self.menuSV.addSubview(V1!.view)
        V1!.didMoveToParentViewController(self)
        V1!.view.frame = menuSV.bounds
        
        //Create frame for the view and define its urigin point with respect to View 1
        var V1Frame: CGRect = V1!.view.frame
        V1Frame.origin.x = 0
        V1!.view.frame = V1Frame
        
        
        //Initialize using Unique ID for the View
        let V2 = self.storyboard?.instantiateViewControllerWithIdentifier("mNVC3")
        //Add initialized view to main view and its scroll view also set bounds
        self.addChildViewController(V2!)
        self.menuSV.addSubview(V2!.view)
        V2!.didMoveToParentViewController(self)
        V2!.view.frame = menuSV.bounds
        
        //Create frame for the view and define its urigin point with respect to View 1
        var V2Frame: CGRect = V2!.view.frame
        V2Frame.origin.x = self.view.frame.width
        V2!.view.frame = V2Frame
        

        
        //The width is set here as we are dealing with Horizontal Scroll
        //The Width is x3 as there are 3 sub views in all
        self.menuSV.contentSize = CGSizeMake((self.view.frame.width) * 2, (self.view.frame.height))
        
        //The offset values are for telling where the scroll view sees its x and y point as origin
        //try setting the value to 2, and 3 to feel the difference----this value here
        self.menuSV.contentOffset = CGPoint(x: 0, y: (self.view.frame.height))
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MainVC.hideBottomBar(_:)),name:"hideBottomBar", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MainVC.showBottomBar(_:)),name:"showBottomBar", object: nil)
        
        let value = UIInterfaceOrientation.Portrait.rawValue
        UIDevice.currentDevice().setValue(value, forKey: "orientation")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    //MARK: folderButtonAction ~ ScrollView Content 1
    @IBAction private func folderButtonAction(sender: UIButton) {
        self.menuSV.setContentOffset(CGPointMake(0, 0), animated: false)
        
    }
    
    //MARK: cameraButtonAction ~ Show Camera
    @IBAction private func cameraButtonAction(sender: UIButton) {
        
        
    }
    
    //MARK: settingsButtonAction ~ ScrollView Content 2
    @IBAction private func settingsButtonAction(sender: UIButton) {
        self.menuSV.setContentOffset(CGPointMake(self.view.frame.width, 0), animated: false)
    
        
    }
    
    
    func showBottomBar(notification: NSNotification){
        
        
        UIView.animateWithDuration(0.5, animations: {
            self.bottomBarView.center.y = self.view.frame.height - 22
        })
        
        
        
    }
    
    func hideBottomBar(notification: NSNotification){
        
        UIView.animateWithDuration(0.5, animations: {
            self.bottomBarView.center.y = self.view.frame.height + 22
        })
        
    }
    
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    
    




}
