//
//  ViewController.swift
//  Keep Safe
//
//  Created by Mert Serin on 31/10/2016.
//  Copyright © 2016 Mert Serin. All rights reserved.
//

import UIKit

class MenuControllerVC: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet private weak var menuSV: UIScrollView!
    @IBOutlet private weak var pageControl: UIPageControl!
    

    var barsHidden = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuSV.delegate = self
        
        //Initialize using Unique ID for the View
        let V1 = self.storyboard?.instantiateViewControllerWithIdentifier("Landing1")
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
        let V2 = self.storyboard?.instantiateViewControllerWithIdentifier("Landing2")
        //Add initialized view to main view and its scroll view also set bounds
        self.addChildViewController(V2!)
        self.menuSV.addSubview(V2!.view)
        V2!.didMoveToParentViewController(self)
        V2!.view.frame = menuSV.bounds
        
        //Create frame for the view and define its urigin point with respect to View 1
        var V2Frame: CGRect = V2!.view.frame
        V2Frame.origin.x = self.view.frame.width
        V2!.view.frame = V2Frame
        
        //Initialize using Unique ID for the View
        let V3 = self.storyboard?.instantiateViewControllerWithIdentifier("Landing3")
        //Add initialized view to main view and its scroll view also set bounds
        self.addChildViewController(V3!)
        self.menuSV.addSubview(V3!.view)
        V3!.didMoveToParentViewController(self)
        V3!.view.frame = menuSV.bounds
        
        //Create frame for the view and define its urigin point with respect to View 1
        var V3Frame: CGRect = V3!.view.frame
        V3Frame.origin.x = self.view.frame.width * 2
        V3!.view.frame = V3Frame
        
        //The width is set here as we are dealing with Horizontal Scroll
        //The Width is x3 as there are 3 sub views in all
        self.menuSV.contentSize = CGSizeMake((self.view.frame.width) * 3, (self.view.frame.height))
        
        //The offset values are for telling where the scroll view sees its x and y point as origin
        //try setting the value to 2, and 3 to feel the difference----this value here
        self.menuSV.contentOffset = CGPoint(x: 0, y: (self.view.frame.height))
        
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(MenuControllerVC.setLandingPage1(_:)),name:"showLanding1", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(MenuControllerVC.setLandingPage2(_:)),name:"showLanding2", object: nil)

        self.menuSV.scrollEnabled = false
        
        
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc private func setLandingPage1(notification: NSNotification){
        
        pageControl.currentPage = 1
        self.menuSV.setContentOffset(CGPointMake(self.view.frame.width * 1, 0), animated: true)
        
        
    }

    
    
    
    @objc private func setLandingPage2(notification: NSNotification){
        
        pageControl.currentPage = 2
        self.menuSV.setContentOffset(CGPointMake(self.view.frame.width * 2, 0), animated: true)
        
    }
    
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        pageControl.currentPage = Int(scrollView.contentOffset.x / self.view.frame.width)
        
    }
    

}
//
//extension MenuControllerVC {
//    override func prefersStatusBarHidden() -> Bool {
//        print("girdim")
//        return barsHidden // this is a custom property
//        
//    }
//    
//    // Override only if you want a different animation than the default
//    override func preferredStatusBarUpdateAnimation() -> UIStatusBarAnimation {
//        return .Fade
//    }
//}
//
