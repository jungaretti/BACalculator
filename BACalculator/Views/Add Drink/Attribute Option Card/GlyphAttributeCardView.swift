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
class GlyphAttributeCardView: AttributeCardView {

    @IBOutlet weak var imageView: UIImageView!
    
    override var updateView: (() -> Void) {
        switch selectedState {
        case .selected:
            return {
                super.updateView()
                self.imageView.tintColor = UIColor.black
            }
        case .deselected:
            return {
                super.updateView()
                self.imageView.tintColor = UIColor.white
            }
        }
    }

}
