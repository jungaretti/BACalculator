//
//  AttributeHeaderTableViewCell.swift
//  BACalculator
//
//  Created by James Ungaretti on 7/28/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import UIKit

/// An `AttributeTableViewCell` that specializes in displaying a label.
class AttributeHeaderTableViewCell: AttributeTableViewCell {
    
    @IBOutlet weak var attributeLabel: UILabel!
    
    override var textLabel: UILabel? {
        return attributeLabel
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        attributeLabel.textColor = UIColor.white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
