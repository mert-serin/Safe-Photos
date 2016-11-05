//
//  FolderTableViewCell.swift
//  Keep Safe
//
//  Created by Mert Serin on 03/11/2016.
//  Copyright © 2016 Mert Serin. All rights reserved.
//

import UIKit
import Haneke
class FolderTableViewCell: UITableViewCell {
    
    
    var state:Int?{
        didSet{
            loadDetails()
        }
    }
    
    @IBOutlet weak var folderLabel: UILabel!
    
    @IBOutlet weak var folderImageView: UIImageView!

    func loadDetails(){
        if(state == 0){
            //Load normal image
            folderLabel.text = "Photos"
            let url = PhotoManager().getImageFromDisk(0)
            
            folderImageView.image = UIImage(contentsOfFile: url)?.RBSquareImage()
            folderImageView.layer.masksToBounds = true
            folderImageView.layer.cornerRadius = 10
        }
        else{
            folderLabel.text = "Wrong password photos"
            let url = PhotoManager().getImageFromDisk(1)

            folderImageView.image = UIImage(contentsOfFile: url)?.RBSquareImage()
            folderImageView.layer.masksToBounds = true
            folderImageView.layer.cornerRadius = 10
            
            
            
            
            
        }
    }
}
