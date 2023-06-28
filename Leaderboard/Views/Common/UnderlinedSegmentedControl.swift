//
//  UnderlinedSegmentedControl.swift
//  Leaderboard
//
//  Created by Oleksandr Strelkov on 2023-06-27.
//

import UIKit

class UnderlinedSegmentedControl: UISegmentedControl {
    override var selectedSegmentIndex: Int {
        didSet {
            self.updateUnderlinePosition()
        }
    }

    private var underlineView: UIView!
    private var underlineLeadingConstraint: NSLayoutConstraint!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func removeAllSegments() {
        super.removeAllSegments()
        updateUnderlineViewConstraints()
    }
    
    override func insertSegment(withTitle title: String?, at segment: Int, animated: Bool) {
        super.insertSegment(withTitle: title, at: segment, animated: animated)
        updateUnderlineViewConstraints()
    }

    private func commonInit() {
        setupUnderlineView()
        addTarget(self, action: #selector(segmentValueChanged), for: .valueChanged)
    }

    private func setupUnderlineView() {
        underlineView = UIView()
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(hex: "#D2D3DA")
        tintColor = backgroundColor
        addSubview(underlineView)

        underlineLeadingConstraint = underlineView.leadingAnchor.constraint(equalTo: leadingAnchor)
        underlineLeadingConstraint.isActive = true
        underlineView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        underlineView.heightAnchor.constraint(equalToConstant: 4).isActive = true
        updateUnderlineViewConstraints()

        underlineView.backgroundColor = UIColor(hex: "#699BF7")
    }

    private func updateUnderlineViewConstraints() {
        if let underlineWidthConstraint = underlineView.constraints.first(where: { $0.identifier == "underlineWidthConstraint" }) {
            underlineWidthConstraint.isActive = false
            underlineView.removeConstraint(underlineWidthConstraint)
        }

        let underlineWidthMultiplier = numberOfSegments > 0 ? 1 / CGFloat(numberOfSegments) : 0
        let underlineWidthConstraint = underlineView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: underlineWidthMultiplier)
        underlineWidthConstraint.identifier = "underlineWidthConstraint"
        underlineWidthConstraint.isActive = true
    }

    private func updateUnderlinePosition() {
        let segmentWidth = bounds.width / CGFloat(numberOfSegments)
        let selectedIndex = selectedSegmentIndex
        let underlineX = segmentWidth * CGFloat(selectedIndex)

        UIView.animate(withDuration: 0.2) {
            self.underlineLeadingConstraint.constant = underlineX
            self.layoutIfNeeded()
        }
    }

    @objc private func segmentValueChanged() {
        updateUnderlinePosition()
    }
}
