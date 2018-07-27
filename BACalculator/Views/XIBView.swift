//
//  XIBView.swift
//  BACalculator
//
//  Created by James Ungaretti on 7/26/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import UIKit

@IBDesignable

/// An object that manages the content for a rectangular area on the screen that is loaded from a XIB file.
class XIBView: UIView {

    /// The view holding the contents of the XIB file.
    var contentView : UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFromXIB()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupFromXIB()
    }
    
    /// Configure the `XIBView` to display the contents of the XIB file.
    func setupFromXIB() {
        contentView = loadViewFromNib()
        contentView.frame = bounds
        contentView.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        addSubview(contentView)
    }
    
    private func loadViewFromNib() -> UIView! {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }

}
