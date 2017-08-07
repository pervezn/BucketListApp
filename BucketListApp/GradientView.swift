//
//  GradientView.swift
//  BucketListApp
//
//  Created by Nida Pervez on 8/7/17.
//  Copyright © 2017 Nida Pervez. All rights reserved.
//

import Foundation
import UIKit
@IBDesignable

class GradientView: UIView {
    
    @IBInspectable var startColor = UIColor(red:0.95, green:0.73, blue:0.65, alpha:1.0)
    @IBInspectable var endColor =  UIColor(red:1.00, green:0.64, blue:0.50, alpha:1.0)
    @IBInspectable var startLocation: Double =   0.05 { didSet { updateLocations() }}
    @IBInspectable var endLocation:   Double =   0.95 { didSet { updateLocations() }}
    @IBInspectable var horizontalMode:  Bool =  false { didSet { updatePoints() }}
    @IBInspectable var diagonalMode:    Bool =  false { didSet { updatePoints() }}
    
    override class var layerClass: AnyClass { return CAGradientLayer.self }
    
    var gradientLayer: CAGradientLayer { return layer as! CAGradientLayer }
    
    func updatePoints() {
        if horizontalMode {
            gradientLayer.startPoint = diagonalMode ? CGPoint(x: 1, y: 0) : CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint   = diagonalMode ? CGPoint(x: 0, y: 1) : CGPoint(x: 1, y: 0.5)
        } else {
            gradientLayer.startPoint = diagonalMode ? CGPoint(x: 0, y: 0) : CGPoint(x: 0.5, y: 0)
            gradientLayer.endPoint   = diagonalMode ? CGPoint(x: 1, y: 1) : CGPoint(x: 0.5, y: 1)
        }
    }
    func updateLocations() {
        gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
    }
    func updateColors() {
        gradientLayer.colors    = [startColor.cgColor, endColor.cgColor]
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updatePoints()
        updateLocations()
        updateColors()
    }
    
//    func setGradientBackground() {
//        let colorTop =  UIColor(red:0.95, green:0.84, blue:0.80, alpha:1.0)
//        let colorBottom = UIColor(red:1.00, green:0.64, blue:0.50, alpha:1.0)
//        
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.colors = [ colorTop, colorBottom]
//        gradientLayer.locations = [ 0.0, 1.0]
//        gradientLayer.frame = self.view.bounds
//        
//        self.view.layer.insertSublayer(gradientLayer, at: 0)
//    }
}
