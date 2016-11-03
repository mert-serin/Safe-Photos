//
//  FolderVC.swift
//  Keep Safe
//
//  Created by Mert Serin on 03/11/2016.
//  Copyright © 2016 Mert Serin. All rights reserved.
//

import UIKit

class FolderVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var folderTableView: UITableView!
    @IBOutlet weak var navBlurView: UIVisualEffectView!
    
    var state = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        folderTableView.delegate = self
        folderTableView.dataSource = self
        
        navBlurView.layer.shadowColor = UIColor.blackColor().colorWithAlphaComponent(1).CGColor
        navBlurView.layer.shadowOffset = CGSize(width: 0, height: 0)
        navBlurView.layer.shadowOpacity = 1
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "showFolderDetailSegue"){
            let vc = segue.destinationViewController as! FolderDetailVC
            print("Mert \(self.state)")
            vc.state = self.state
        }
    }
    


}

extension FolderVC{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! FolderTableViewCell
        
        cell.state = indexPath.row
        
        return cell
        
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.state = indexPath.row
        print("Mert \(state)")
        performSegueWithIdentifier("showFolderDetailSegue", sender: nil)
    }
}
