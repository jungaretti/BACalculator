//
//  TypeAttributeCardView.swift
//  BACalculator
//
//  Created by James Ungaretti on 7/26/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import UIKit

@IBDesignable

/// An `AttributeCardView` for the `type` property of a `Drink`.
class TypeAttributeCardView: GlyphAttributeCardView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.contentMode = .scaleAspectFit
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        imageView.contentMode = .scaleAspectFit
    }
    
}
