//
//  AttributeHeaderActionTableViewCell.swift
//  BACalculator
//
//  Created by James Ungaretti on 7/28/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import UIKit

/// An `AttributeTableViewCell` that specializes in displaying a label and a button.
class AttributeHeaderActionTableViewCell: AttributeHeaderTableViewCell {
    
    @IBOutlet weak var attributeButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        attributeButton.setTitleColor(UIColor.white, for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
