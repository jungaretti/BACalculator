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
    
    override var updateView: (() -> Void) {
        switch selectedState {
        case .selected:
            return {
                super.updateView()
                self.textLabel.textColor = UIColor.black
            }
        case .deselected:
            return {
                super.updateView()
                self.textLabel.textColor = UIColor.white
            }
        }
    }

}
