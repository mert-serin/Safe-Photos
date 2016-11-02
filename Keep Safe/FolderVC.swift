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
    var frame:CGRect?
    override func viewDidLoad() {
        super.viewDidLoad()

        folderTableView.delegate = self
        folderTableView.dataSource = self
        
        frame = folderTableView.frame
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
}
