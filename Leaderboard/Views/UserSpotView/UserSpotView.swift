//
//  UserSpotView.swift
//  Leaderboard
//
//  Created by Oleksandr Strelkov on 2023-06-26.
//

import UIKit

class UserSpotView: LoadableFromXibView {
    var isCrownHidden = true {
        didSet {
            crownImageView.isHidden = isCrownHidden
            if isCrownHidden {
                iconWidth = 68
            } else {
                iconWidth = 82
            }
        }
    }
    
    private var iconWidth: CGFloat = 68 {
        didSet {
            iconWidthConstraint.constant = iconWidth
            updateBorder()
        }
    }
    
    var user: User? {
        didSet {
            nameLabel.text = user?.name
            usernameLabel.text = user?.username
            if let imageName = user?.icon {
                iconImageView.image = UIImage(named: imageName)
            } else {
                iconImageView.image = nil
            }
            
            if let score = user?.score {
                scoreLabel.text = String(score)
            } else {
                scoreLabel.text = ""
            }
        }
    }
    
    var color: UIColor? {
        didSet {
            if let color {
                iconImageView.layer.borderColor = color.cgColor
                scoreLabel.textColor = color
            } else {
                iconImageView.layer.borderColor = nil
                scoreLabel.textColor = nil
            }
        }
    }
    
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var crownImageView: UIImageView!
    @IBOutlet private weak var iconWidthConstraint: NSLayoutConstraint!

    override func commotInit() {
        super.commotInit()
        
        iconImageView.layer.masksToBounds = true
        iconImageView.layer.borderColor = UIColor.orange.cgColor
        iconImageView.layer.borderWidth = 6
        crownImageView.isHidden = isCrownHidden
        updateBorder()
    }
    
    private func updateBorder() {
        iconImageView.layer.cornerRadius = iconWidth / 2
    }
}
