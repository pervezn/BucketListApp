//
//  NewTableViewCell.swift
//  BucketListApp
//
//  Created by Nida Pervez on 7/11/17.
//  Copyright © 2017 Nida Pervez. All rights reserved.
//

import UIKit


protocol NewCellDelegate: class {
    func addListItem(_ listItemTextField: UITextField, on cell: NewTableViewCell)
}

class NewTableViewCell: UITableViewCell {


    @IBOutlet weak var locationNameDisplay: UILabel!
    @IBOutlet weak var locationAddressDisplay: UILabel!
    
    var view = AddLocationMapViewController()
    
    
    weak var delegate: NewTableViewCell?
//    var editing: Bool = false {
//        didSet {
//            self.
//        }
//    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       // print("in Nib")      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
