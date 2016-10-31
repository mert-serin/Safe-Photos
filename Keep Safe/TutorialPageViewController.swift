//
//  LandingPageViewController.swift
//  Keep Safe
//
//  Created by Mert Serin on 31/10/2016.
//  Copyright © 2016 Mert Serin. All rights reserved.
//

import UIKit

class LandingPageViewController: UIPageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
