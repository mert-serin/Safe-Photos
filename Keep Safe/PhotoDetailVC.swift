//
//  PhotoDetailVC.swift
//  Keep Safe
//
//  Created by Mert Serin on 05/11/2016.
//  Copyright © 2016 Mert Serin. All rights reserved.
//

import UIKit
import Haneke
class PhotoDetailVC: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var url = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        print(url)
        
        loadPhoto()
        
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        //Hide Bottom Bar
        NSNotificationCenter.defaultCenter().postNotificationName("hideBottomBar", object: nil)
    }
    
    
    
    override func viewWillDisappear(animated: Bool) {
        //Show Bottom Bar Again
        NSNotificationCenter.defaultCenter().postNotificationName("showBottomBar", object: nil)

    }

    
    
    func loadPhoto(){
        self.imageView.image = UIImage(contentsOfFile: url)
    }
    
    
    @IBAction func backButtonAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    


}
