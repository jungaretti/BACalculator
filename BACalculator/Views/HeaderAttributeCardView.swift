//
//  HeaderAttributeCardView.swift
//  BACalculator
//
//  Created by James Ungaretti on 7/26/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import UIKit

@IBDesignable

/// An `AttributeCardView` with a textual header.
class HeaderAttributeCardView: AttributeCardView {
    
    @IBOutlet weak var textLabel: UILabel!
    
    override func setSelected(state: AttributeCardViewSelectedState) {
        super.setSelected(state: state)
        switch state {
        case .deselected:
            textLabel.textColor = .white
        case .selected:
            textLabel.textColor = .black
        }
    }

}
