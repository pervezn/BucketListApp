//
//  CollectionViewCell.swift
//  BucketListApp
//
//  Created by Nida Pervez on 7/10/17.
//  Copyright © 2017 Nida Pervez. All rights reserved.
//

import UIKit

protocol CollectionViewDelegate: class {
    func delete(cell: CollectionViewCell)
}

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleButton: UIButton!
    @IBOutlet weak var titleButtonPressed: UIButton!
    @IBOutlet weak var deleteButtonBackgroundView: UIVisualEffectView!
    
    weak var delegate : CollectionViewDelegate?
    
    var imageName: String! {
        didSet {
            deleteButtonBackgroundView.layer.cornerRadius = deleteButtonBackgroundView.bounds.width / 2.0
            deleteButtonBackgroundView.layer.masksToBounds = true
            deleteButtonBackgroundView.isHidden = !isEditing
        }
    }
    
    var isEditing: Bool = false {
        didSet {
            deleteButtonBackgroundView.isHidden = !isEditing
        }
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        delegate?.delete(cell: self)
    }
   
}
