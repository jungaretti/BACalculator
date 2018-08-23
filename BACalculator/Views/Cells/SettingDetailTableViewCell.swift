//
//  SettingDetailTableViewCell.swift
//  BACalculator
//
//  Created by James Ungaretti on 8/23/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import UIKit

class SettingDetailTableViewCell: SettingBasicTableViewCell {
    
    @IBOutlet weak var settingDetailLabel: UILabel!
    
    override var detailTextLabel: UILabel? {
        return settingDetailLabel
    }

}
