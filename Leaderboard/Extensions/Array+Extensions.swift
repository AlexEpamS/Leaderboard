//
//  Array+Extensions.swift
//  Leaderboard
//
//  Created by Oleksandr Strelkov on 2023-06-28.
//

import Foundation

extension Array where Element: Equatable {
    func getNextElement(after element: Element) -> Element? {
        guard let currentIndex = self.firstIndex(of: element),
              currentIndex < self.count - 1 else {
            return nil
        }
        return self[currentIndex + 1]
    }

    func getPreviousElement(before element: Element) -> Element? {
        guard let currentIndex = self.firstIndex(of: element),
              currentIndex > 0 else {
            return nil
        }
        return self[currentIndex - 1]
    }
}
