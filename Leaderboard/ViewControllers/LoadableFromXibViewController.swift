//
//  LoadableFromXibViewController.swift
//  Leaderboard
//
//  Created by Oleksandr Strelkov on 2023-06-27.
//

import UIKit

class LoadableFromXibViewController: UIViewController {
    override func loadView() {
        let view = UINib(nibName: className, bundle: nil).instantiate(withOwner: self, options: nil)[0] as! UIView
        self.view = view
    }

}
