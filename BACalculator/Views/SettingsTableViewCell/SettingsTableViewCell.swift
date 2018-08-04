//
//  SettingsTableViewCell.swift
//  BACalculator
//
//  Created by James Ungaretti on 8/2/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    var detailTableViewDataSourceType: SettingsDetailTableViewDataSource.Type?
    var detailTableViewDelegateType: SettingsDetailTableViewDelegate.Type?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
