//
//  ShapeView.swift
//  Leaderboard
//
//  Created by Oleksandr Strelkov on 2023-06-27.
//

import UIKit

import UIKit

class ShapeView: UIView {
    override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }
    
    var shapeLayer: CAShapeLayer {
        return layer as! CAShapeLayer
    }
    
    var shapePath: UIBezierPath? {
        didSet {
            updateShape()
        }
    }
    
    var fillColor: UIColor? {
        didSet {
            updateFillColor()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        backgroundColor = UIColor.clear
        setupShapeLayer()
    }
    
    private func setupShapeLayer() {
        fillColor = UIColor.clear
    }
    
    private func updateShape() {
        shapeLayer.path = shapePath?.cgPath
    }
    
    private func updateFillColor() {
        shapeLayer.fillColor = fillColor?.cgColor
    }
}
