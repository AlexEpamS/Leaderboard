//
//  LeadersViewController.swift
//  Leaderboard
//
//  Created by Oleksandr Strelkov on 2023-06-26.
//

import UIKit

class LeadersViewController: LoadableFromXibViewController {
    var users = [User]() {
        didSet {
            updateData()
        }
    }
    
    @IBOutlet weak var winnersView: WinnersPedestalView!
    @IBOutlet weak var tableView: UITableView!
    
    private var tableLeaders = [User]()

    override func loadView() {
        let view = UINib(nibName: "LeadersViewController", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! UIView
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserTableViewCell")
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(hex: "#DFDFDF")
        backgroundView.layer.cornerRadius = 40
        backgroundView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        backgroundView.layer.masksToBounds = true
        tableView.backgroundView = backgroundView
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 1))
        tableView.tableHeaderView = headerView

        updateData()
    }
    
    private func updateData() {
        let leaders = users.sorted(by: { user1, user2 in
            user1.score > user2.score
        })
        let startIndex = 3
        if leaders.count > startIndex {
            tableLeaders = Array(leaders.suffix(from: startIndex))
        } else {
            tableLeaders = []
        }
        guard isViewLoaded else { return }
        winnersView.loadFromArray(leaders)
        tableView.reloadData()
    }
}

extension LeadersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableLeaders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath)
        guard let userCell = cell as? UserTableViewCell else {
            return cell
        }
        let user = tableLeaders[indexPath.row]
        let imageName = user.icon
        var image = UIImage(named: imageName)

        userCell.iconImageView.image = image
        userCell.nameLabel.text = user.name
        userCell.usernameLabel.text = user.username
        userCell.ratingLabel.text = String(user.score)
        userCell.deltaView.direction = user.scoreDelta > 0 ? .up : .down
        userCell.deltaView.isHidden = (user.scoreDelta == 0)

        return userCell
    }
}

