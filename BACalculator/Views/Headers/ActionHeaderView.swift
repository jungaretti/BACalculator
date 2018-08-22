//
//  ActionHeaderView.swift
//  BACalculator
//
//  Created by James Ungaretti on 8/20/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import UIKit

class ActionHeaderView: HeaderView {

    var actionButton: UIButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        designActionButton()
        layoutActionButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func designActionButton() {
        actionButton.titleLabel?.textAlignment = .right
        actionButton.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 17.0)!
    }
    
    private func layoutActionButton() {
        addSubview(actionButton)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.0).isActive = true
        actionButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }

}
