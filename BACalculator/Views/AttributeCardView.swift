//
//  AttributeCardView.swift
//  BACalculator
//
//  Created by James Ungaretti on 7/26/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import UIKit

@IBDesignable

/// An object that displays an attribute of a drink.
class AttributeCardView: XIBView {
    
    /// The selection state of the `AttributeCardView`.
    var selectedState: AttributeCardViewSelectedState!
    
    @IBOutlet weak var detailTextLabel: UILabel!
    
    /// Set the selection state of the `AttributeCardView`.
    ///
    /// - Parameter state: The new selection state of the `AttributeCardView`.
    func setSelected(state: AttributeCardViewSelectedState) {
        selectedState = state
        switch state {
        case .deselected:
            contentView.backgroundColor = UIColor.black.withAlphaComponent(0.10)
            detailTextLabel.textColor = .white
        case .selected:
            contentView.backgroundColor = .white
            detailTextLabel.textColor = .black
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setSelected(state: .deselected)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = .clear
        setSelected(state: .deselected)
    }

}

/// Constants to describe selection states of an `AttributeCardView`.
///
/// - selected: An `AttributeCardView` with a dark background and white text.
/// - deselected: An `AttributeCardView` with a white background and dark text.
enum AttributeCardViewSelectedState {
    
    case selected
    case deselected
    
}
