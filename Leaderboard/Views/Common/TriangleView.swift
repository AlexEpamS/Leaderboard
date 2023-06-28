//
//  TriangleView.swift
//  Leaderboard
//
//  Created by Oleksandr Strelkov on 2023-06-27.
//

import UIKit

class TriangleView: ShapeView {
    enum TriangleDirection {
        case up
        case down
        
        var color: UIColor {
            let result: UIColor
            switch self {
            case .up:
                result = UIColor(hex: "#00D95F")    // green
            case .down:
                result = UIColor(hex: "#D82953")    // red
            }
            return result
        }
    }
    
    var direction: TriangleDirection = .up {
        didSet {
            updateTriangle()
        }
    }
    
    override func commonInit() {
        super.commonInit()
        updateTriangle()
    }
    
    private func updateTriangle() {
        let trianglePath = UIBezierPath()
        
        switch direction {
        case .up:
            trianglePath.move(to: CGPoint(x: bounds.minX, y: bounds.maxY))
            trianglePath.addLine(to: CGPoint(x: bounds.midX, y: bounds.minY))
            trianglePath.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
        case .down:
            trianglePath.move(to: CGPoint(x: bounds.minX, y: bounds.minY))
            trianglePath.addLine(to: CGPoint(x: bounds.midX, y: bounds.maxY))
            trianglePath.addLine(to: CGPoint(x: bounds.maxX, y: bounds.minY))
        }
        
        fillColor = direction.color
        shapePath = trianglePath
    }
}
