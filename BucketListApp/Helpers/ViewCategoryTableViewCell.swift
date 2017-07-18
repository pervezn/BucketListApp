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
    @IBOutlet weak var titleLabel: UILabel!
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    @IBAction func completeButtonPressed(_ sender: UIButton) {
       delegate?.didTapCompleteButton(sender, on: self)
        
        
    }
    

}
