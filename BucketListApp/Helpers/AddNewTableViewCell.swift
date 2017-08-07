//
//  AddNewTableViewCell.swift
//  BucketListApp
//
//  Created by Nida Pervez on 7/11/17.
//  Copyright © 2017 Nida Pervez. All rights reserved.
//

import UIKit

protocol AddNewCellDelegate: class {
    func didPressAddButton(_ addListItemButton: UIButton, on cell: AddNewTableViewCell)
}



class AddNewTableViewCell: UITableViewCell {

    @IBOutlet weak var addListItemButton: UIButton!
    weak var delegate: AddNewCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func AddListItemButtonPressed(_ sender: Any) {
        delegate?.didPressAddButton(sender as! UIButton, on: self)
        
    }
}
