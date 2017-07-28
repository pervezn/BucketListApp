//
//  ViewCategoryTableViewCell.swift
//  BucketListApp
//
//  Created by Nida Pervez on 7/10/17.
//  Copyright © 2017 Nida Pervez. All rights reserved.
//

import UIKit


//protocol ViewCategoryCellDelegate: class {
//    func didTapCompleteButton(_ completeButton: UIButton, on cell: ViewCategoryTableViewCell)
//}

class ViewCategoryTableViewCell: UITableViewCell {

    //weak var delegate: ViewCategoryCellDelegate?
    
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var itemAddress: UILabel!
    
    

    
    @IBAction func completeButtonPressed(_ sender: UIButton) {
      // delegate?.didTapCompleteButton(sender, on: self)
        //print("complete button pressed")
        if completeButton.currentImage == UIImage(named: "Icon-60") {
            completeButton.setImage(UIImage(named: "gIcon-60.png"), for: .normal)
        } else {
            completeButton.setImage(UIImage(named: "Icon-60.png"), for: .normal)
        }
        
    }
    

}
