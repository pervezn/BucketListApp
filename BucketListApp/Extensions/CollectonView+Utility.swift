//
//  CollectonView+Utility.swift
//  BucketListApp
//
//  Created by Nida Pervez on 7/10/17.
//  Copyright © 2017 Nida Pervez. All rights reserved.
//

//import Foundation
//import UIKit
//
//protocol CellIdentifiable {
//    static var cellIdentifier: String { get }
//}
//
//extension CellIdentifiable where Self: UICollectionViewCell {
//    // 2
//    static var cellIdentifier: String {
//        return String(describing: self)
//    }
//}
//
//// 3
//extension UICollectionViewCell: CellIdentifiable {
//    
//}
//
//extension UICollectionView {
//    // 1
//    func dequeueReusableCell<T: UICollectionViewCell>() -> T where T: CellIdentifiable {
//        // 2
//        guard let cell = dequeueReusableCell(withReuseIdentifier: T.cellIdentifier, for: indexPath(for: CellIdentifiable)) as? T else {
//            // 3
//            fatalError("Error dequeuing cell for identifier \(T.cellIdentifier)")
//        }
//        
//        return cell
//    }
//}
