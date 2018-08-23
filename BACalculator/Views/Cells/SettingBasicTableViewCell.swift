//
//  SettingBasicTableViewCell.swift
//  BACalculator
//
//  Created by James Ungaretti on 8/23/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import UIKit

class SettingBasicTableViewCell: UITableViewCell {
    
    var setting: AppSetting!
    
    @IBOutlet weak var settingLabel: UILabel!
    
    override var textLabel: UILabel? {
        return settingLabel
    }

}
