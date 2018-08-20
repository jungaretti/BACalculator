//
//  HeaderView.swift
//  BACalculator
//
//  Created by James Ungaretti on 8/19/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import UIKit

class HeaderView: UIView {

    var textLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        designTextLabel()
        layoutTextLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func designTextLabel() {
        textLabel.textAlignment = .left
        textLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 17.0)!
    }
    
    private func layoutTextLabel() {
        addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0).isActive = true
        textLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
}
