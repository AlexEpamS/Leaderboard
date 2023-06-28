//
//  NSObject+Extensions.swift
//  Leaderboard
//
//  Created by Oleksandr Strelkov on 2023-06-27.
//

import Foundation

extension NSObject {
    var className: String {
        let className = NSStringFromClass(Self.self)
        let result = className.components(separatedBy: ".").last ?? className
        return result
    }
}
