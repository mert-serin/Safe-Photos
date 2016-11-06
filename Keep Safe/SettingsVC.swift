//
//  SettingsVC.swift
//  Keep Safe
//
//  Created by Mert Serin on 03/11/2016.
//  Copyright © 2016 Mert Serin. All rights reserved.
//

import UIKit
import KVNProgress
class SettingsVC: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
    }
    
    
    func showAlert(state:Int){
        
        var title:String{
            if(state == 0){
                return "email address"
            }
            else{
                return "password"
            }
        }
        
        
        var alert = UIAlertController(title: "Please enter your new \(title)", message: "", preferredStyle: .Alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.placeholder = "Your new \(title)"
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .Destructive, handler: { (action) -> Void in
            
            
            
        }))
        
        //3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            let textField = alert.textFields![0] as UITextField
            if let new = textField.text{
                KVNProgress.show()
                if(state == 0){
                    if(User().setEmail(new)){
                        KVNProgress.showSuccessWithStatus("Your email address has been changed successfully")
                    }
                    else{
                        
                    }
                }
                else{
                    if(User().setPassword(new)){
                       KVNProgress.showSuccessWithStatus("Your password has been changed successfully")
                    }
                    else{
                        
                    }
                }
            }
            self.tableView.reloadData()
        }))
        
        
        
        // 4. Present the alert.
        self.presentViewController(alert, animated: true, completion: nil)
    }

    
    
    

}

extension SettingsVC{
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        if(indexPath.row == 0){
            cell?.textLabel?.text = "Change Email address"
            cell?.detailTextLabel?.text = "\(NSUserDefaults.standardUserDefaults().objectForKey("email")!)"
            cell?.imageView?.image = UIImage(named: "email")
        }
        else{
            cell?.textLabel?.text = "Change password"
            cell?.detailTextLabel?.text = ""
            cell?.imageView?.image = UIImage(named: "key")
        }
        
        return cell!
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.row == 0){
            showAlert(0)
        }
        else{
            showAlert(1)
        }
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
    
}
