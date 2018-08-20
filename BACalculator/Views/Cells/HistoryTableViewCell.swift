//
//  HistoryTableViewCell.swift
//  BACalculator
//
//  Created by James Ungaretti on 8/19/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override var textLabel: UILabel? {
        return typeLabel
    }
    override var detailTextLabel: UILabel? {
        return sizeLabel
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        typeLabel.textColor = .white
        sizeLabel.textColor = .white
        dateLabel.textColor = .white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
