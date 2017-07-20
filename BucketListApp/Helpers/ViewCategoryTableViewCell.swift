//
//  ViewCategoryTableViewCell.swift
//  BucketListApp
//
//  Created by Nida Pervez on 7/10/17.
//  Copyright © 2017 Nida Pervez. All rights reserved.
//

import UIKit


protocol ViewCategoryDelegate: class {
    func didTapCompleteButton(_ completeButton: UIButton, on cell: ViewCategoryTableViewCell)
}

class ViewCategoryTableViewCell: UITableViewCell {

    weak var delegate: ViewCategoryDelegate?
    
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var itemLabel: UILabel!
    
    

    
    @IBAction func completeButtonPressed(_ sender: UIButton) {
       delegate?.didTapCompleteButton(sender, on: self)
        
        
    }
    

}
