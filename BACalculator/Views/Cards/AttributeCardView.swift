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
    
    /// Constants to describe selection states of an `AttributeOptionCardView`.
    ///
    /// - selected: An `AttributeOptionCardView` with a dark background and white text.
    /// - deselected: An `AttributeOptionCardView` with a white background and dark text.
    enum AttributeCardViewSelectedState {
        
        case selected
        case deselected
        
    }
    
    @IBOutlet weak var detailTextLabel: UILabel!

    /// The selection state of the `AttributeCardView`.
    var selectedState: AttributeCardViewSelectedState = .deselected
    /// A function to update the `AttributeCardView` to match the current `selectedState`.
    var updateView: (() -> Void) {
        switch selectedState {
        case .selected:
            return {
                self.contentView.backgroundColor = UIColor.white
                self.detailTextLabel.textColor = UIColor.black
            }
        case .deselected:
            return {
                self.contentView.backgroundColor = UIColor.black.withAlphaComponent(0.10)
                self.detailTextLabel.textColor = UIColor.white
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        updateView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = .clear
        updateView()
    }
    
    /// Set the selection state of the `AttributeCardView`.
    ///
    /// - Parameters:
    ///   - state: The state to set the card to.
    ///   - animated: If `true`, changes to the card will be animated.
    func setSelectedState(_ state: AttributeCardViewSelectedState, animated: Bool) {
        self.selectedState = state
        if animated {
            UIView.animate(withDuration: 0.25, delay: 0.0, options: [.beginFromCurrentState, .beginFromCurrentState], animations: self.updateView, completion: nil)
        } else {
            self.updateView()
        }
    }

}
