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

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
