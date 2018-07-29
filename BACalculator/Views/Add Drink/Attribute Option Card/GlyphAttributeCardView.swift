//
//  GlyphAttributeCardView.swift
//  BACalculator
//
//  Created by James Ungaretti on 7/26/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import UIKit

@IBDesignable

/// An `AttributeCardView` that has an accompanying image.
class GlyphAttributeCardView: AttributeOptionCardView {

    @IBOutlet weak var imageView: UIImageView!
    
    override func setSelected(state: AttributeCardViewSelectedState) {
        super.setSelected(state: state)
        switch state {
        case .deselected:
            imageView.tintColor = .white
        case .selected:
            imageView.tintColor = .black
        }
    }

}
