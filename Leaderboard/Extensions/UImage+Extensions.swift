//
//  UImage+Extensions.swift
//  Leaderboard
//
//  Created by Oleksandr Strelkov on 2023-06-28.
//

import UIKit

extension UIImage {
    convenience init?(color: UIColor, size: CGSize) {
        let renderer = UIGraphicsImageRenderer(size: size)
        let image = renderer.image { context in
            color.setFill()
            context.fill(CGRect(origin: .zero, size: size))
        }
        self.init(cgImage: image.cgImage!)
    }
}
