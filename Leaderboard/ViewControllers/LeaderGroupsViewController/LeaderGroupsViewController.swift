//
//  LeaderGroupsViewController.swift
//  Leaderboard
//
//  Created by Oleksandr Strelkov on 2023-06-27.
//

import UIKit

let usersArray1 = [
    User(name: "Matthew", username: "@supergirl", score: 1847, scoreDelta: 23, icon: "ProfileIcon2"),
    User(name: "Jacob", username: "@lastcop", score: 3056, scoreDelta: 40, icon: "ProfileIcon1"),
    User(name: "Ruben", username: "@starboy", score: 1674, scoreDelta: -56, icon: "ProfileIcon3"),
    User(name: "Clifford", username: "@thegamer", score: 1134, scoreDelta: 10, icon: "ProfileIcon4"),
    User(name: "Tara", username: "@musiclover", score: 845, scoreDelta: -12, icon: "ProfileIcon5"),
    User(name: "Pascal", username: "@techwizard", score: 760, scoreDelta: 5, icon: "ProfileIcon6"),
    User(name: "Quincy", username: "@foodie", score: 734, scoreDelta: 17, icon: "ProfileIcon7"),
    User(name: "Oliver", username: "@adventurer", score: 544, scoreDelta: -8, icon: "ProfileIcon8"),
    User(name: "Sophia", username: "@mystic", score: 518, scoreDelta: 50, icon: "ProfileIcon9"),
    User(name: "Emma", username: "@naturelover", score: 495, scoreDelta: -30, icon: "ProfileIcon10")
]

let usersArray2 = [
    User(name: "Liam", username: "@captain", score: 2512, scoreDelta: 15, icon: "ProfileIcon4"),
    User(name: "Ava", username: "@explorer", score: 1837, scoreDelta: -25, icon: "ProfileIcon7"),
    User(name: "Noah", username: "@coolguy", score: 1574, scoreDelta: 12, icon: "ProfileIcon6"),
    User(name: "Isabella", username: "@sunshine", score: 2245, scoreDelta: 0, icon: "ProfileIcon2"),
    User(name: "Ethan", username: "@daredevil", score: 1976, scoreDelta: -20, icon: "ProfileIcon9"),
    User(name: "Mia", username: "@creativemind", score: 3623, scoreDelta: 30, icon: "ProfileIcon3"),
    User(name: "Liam", username: "@captain", score: 2178, scoreDelta: -5, icon: "ProfileIcon5"),
    User(name: "Harper", username: "@writer", score: 2136, scoreDelta: 0, icon: "ProfileIcon10"),
    User(name: "Mason", username: "@adrenaline", score: 2449, scoreDelta: -15, icon: "ProfileIcon1"),
    User(name: "Evelyn", username: "@dreamer", score: 1754, scoreDelta: 8, icon: "ProfileIcon8")
]

let usersArray3 = [
    User(name: "Olivia", username: "@wildflower", score: 1983, scoreDelta: 10, icon: "ProfileIcon3"),
    User(name: "James", username: "@mastermind", score: 2745, scoreDelta: -15, icon: "ProfileIcon7"),
    User(name: "Sophia", username: "@nightowl", score: 1598, scoreDelta: 18, icon: "ProfileIcon2"),
    User(name: "Michael", username: "@thinker", score: 2076, scoreDelta: 22, icon: "ProfileIcon1"),
    User(name: "Charlotte", username: "@adventurer", score: 1825, scoreDelta: -0, icon: "ProfileIcon5"),
    User(name: "Artem", username: "@gamer", score: 4099, scoreDelta: 25, icon: "ProfileIcon8"),
    User(name: "Emma", username: "@wanderlust", score: 2234, scoreDelta: -10, icon: "ProfileIcon6"),
    User(name: "Liam", username: "@champion", score: 2367, scoreDelta: 12, icon: "ProfileIcon10"),
    User(name: "Oliver", username: "@dreamer", score: 2612, scoreDelta: -8, icon: "ProfileIcon4"),
    User(name: "Sophia", username: "@sunshine", score: 1923, scoreDelta: 15, icon: "ProfileIcon9")
]

struct LeadersPage {
    let name: String
    let users: [User]
}

let page1 = LeadersPage(name: "Region", users: usersArray1)
let page2 = LeadersPage(name: "National", users: usersArray2)
let page3 = LeadersPage(name: "Global", users: usersArray3)

class LeaderGroupsViewController: LoadableFromXibViewController {
    var pages = [page1, page2, page3] {
        didSet {
            updateViewControllers()
        }
    }
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var segmentedControl: UnderlinedSegmentedControl!
    
    private var viewControllers = [LeadersViewController]()
    private lazy var pageController: UIPageViewController = {
        let result = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal,
            options: [.interPageSpacing: 10]
        )
        result.dataSource = self
        result.delegate = self
        return result
    }() {
        didSet {
            updatePageController()
        }
    }
    private var isTabChanging = false
    private var isPageChanging = false
    
    private var currentPageIndex: Int = 0 {
        didSet {
            handleCurrentPageIndexDidChange(previosPageIndex: oldValue)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func segmentedControlAction(_ sender: Any) {
        isTabChanging = true
        currentPageIndex = segmentedControl.selectedSegmentIndex
        isTabChanging = false
    }
    
    private func updateViewControllers() {
        viewControllers.removeAll()
        for page in pages {
            let viewController = LeadersViewController()
            viewController.users = page.users
            viewControllers.append(viewController)
        }
        updatePageController()
    }
    
    private func updatePageController() {
        guard let initialViewController = viewControllers.first else { return }
        let viewControllers = [initialViewController]
        pageController.setViewControllers(viewControllers, direction: .forward, animated: false)
    }
    
    private func setupUI() {
        title = "Leaderboard"
        updateViewControllers()

        self.addChild(pageController)
        contentView.addSubview(pageController.view)
        pageController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pageController.view.topAnchor.constraint(equalTo: contentView.topAnchor),
            pageController.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            pageController.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            pageController.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        pageController.didMove(toParent: self)
        
        segmentedControl.removeAllSegments()
        for (index, page) in pages.enumerated() {
            segmentedControl.insertSegment(withTitle: page.name, at: index, animated: false)
        }

        let fontAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 18, weight: .regular)
        ]
        segmentedControl.setTitleTextAttributes(fontAttributes, for: .normal)
        segmentedControl.setTitleTextAttributes(fontAttributes, for: .selected)
    }

    private func handleCurrentPageIndexDidChange(previosPageIndex: Int) {
        updateSegmentedControlWithCurrentIndex(previosPageIndex: previosPageIndex)
        updatePageControllerWithCurrentIndex(previosPageIndex: previosPageIndex)
    }

    private func updateSegmentedControlWithCurrentIndex(previosPageIndex: Int) {
        guard isTabChanging == false else { return }
        segmentedControl.selectedSegmentIndex = currentPageIndex
    }

    private func updatePageControllerWithCurrentIndex(previosPageIndex: Int) {
        guard isPageChanging == false else { return }
        let newViewController = viewControllers[currentPageIndex]
        let direction: UIPageViewController.NavigationDirection = previosPageIndex > currentPageIndex ? .reverse : .forward

        pageController.setViewControllers(
            [newViewController],
            direction: direction,
            animated: true
        )
    }
}

extension LeaderGroupsViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let result = viewControllers.getPreviousElement(before: viewController as! LeadersViewController)
        return result
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let result = viewControllers.getNextElement(after: viewController as! LeadersViewController)
        return result
    }
}

extension LeaderGroupsViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        isPageChanging = true
        
        if let index = viewControllers.firstIndex(of: pageViewController.viewControllers?.first as! LeadersViewController) {
            currentPageIndex = index
        }
        isPageChanging = false
    }
}
