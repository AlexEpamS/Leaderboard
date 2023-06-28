//
//  UserTableViewCell.swift
//  Leaderboard
//
//  Created by Oleksandr Strelkov on 2023-06-26.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var deltaView: TriangleView!
    @IBOutlet weak var separatorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        separatorView.backgroundColor = UIColor(hex: "#5F5959", alpha: 0.54)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let radius = iconImageView.frame.width / 2
        iconImageView.layer.cornerRadius = radius
    }
}
