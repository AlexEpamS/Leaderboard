//
//  WinnersPedestalView.swift
//  Leaderboard
//
//  Created by Oleksandr Strelkov on 2023-06-23.
//

import UIKit

class WinnersPedestalView: LoadableFromXibView {
    
    var firstPlaceUser: User? {
        didSet {
            firstPlaceView.user = firstPlaceUser
        }
    }
    var secondPlaceUser: User? {
        didSet {
            secondPlaceView.user = secondPlaceUser
        }
    }
    var thirdPlaceUser: User? {
        didSet {
            thirdPlaceView.user = thirdPlaceUser
        }
    }
    
    @IBOutlet private var firstPlaceView: UserSpotView!
    @IBOutlet private var secondPlaceView: UserSpotView!
    @IBOutlet private var thirdPlaceView: UserSpotView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var middleView: UIView!
    
    override func commotInit() {
        super.commotInit()
        
        firstPlaceView.color = UIColor(hex: "#FFAA00")
        firstPlaceView.isCrownHidden = false
        secondPlaceView.color = UIColor(hex: "#009BD6")
        thirdPlaceView.color = UIColor(hex: "#00D95F")
        
        middleView.layer.cornerRadius = 30
        middleView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        bottomView.layer.cornerRadius = 12
    }

    func loadFromArray(_ array: [User]) {
        firstPlaceUser = array.indices.contains(0) ? array[0] : nil
        secondPlaceUser = array.indices.contains(1) ? array[1] : nil
        thirdPlaceUser = array.indices.contains(2) ? array[2] : nil
    }
}
