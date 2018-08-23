//
//  SettingsPickerTableViewCell.swift
//  BACalculator
//
//  Created by James Ungaretti on 8/4/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import UIKit

class SettingsPickerTableViewCell: SettingsTableViewCell {
    
    // MARK: Properties
    
    var pickerViewDataSourceType: SettingsPickerViewDataSource.Type?
    var pickerViewDelegateType: SettingsPickerViewDelegate.Type?
    var detailTextLabelUpdateFunction: ( () -> String? )?
    
    // MARK: Methods

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
