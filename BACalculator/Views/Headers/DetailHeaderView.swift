//
//  DetailHeaderView.swift
//  BACalculator
//
//  Created by James Ungaretti on 8/19/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import UIKit

class DetailHeaderView: HeaderView {
    
    var detailTextLabel: UILabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        designDetailTextLabel()
        layoutDetailTextLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func designDetailTextLabel() {
        detailTextLabel.textAlignment = .right
        detailTextLabel.font = UIFont(name: "AvenirNext-Medium", size: 17.0)!
    }
    
    private func layoutDetailTextLabel() {
        addSubview(detailTextLabel)
        detailTextLabel.translatesAutoresizingMaskIntoConstraints = false
        detailTextLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.0).isActive = true
        detailTextLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }

}
