//
//  AttributeDetailTableViewCell.swift
//  BACalculator
//
//  Created by James Ungaretti on 7/29/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import UIKit

/// An `AttributeTableViewCell` that specializes in displaying a label and detail label.
class AttributeDetailTableViewCell: AttributeTableViewCell {
    
    @IBOutlet weak var attributeLabel: UILabel!
    @IBOutlet weak var attributeDetailLabel: UILabel!
    
    override var textLabel: UILabel? {
        return attributeLabel
    }
    override var detailTextLabel: UILabel? {
        return attributeDetailLabel
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
