//
//  SettingsPickerViewDelegate.swift
//  BACalculator
//
//  Created by James Ungaretti on 7/31/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import Foundation
import UIKit

class SettingsPickerViewDelegate: NSObject, UIPickerViewDelegate {
    
    weak var delegate: SettingsDetailDelegate?
    
    required override init() {
        super.init()
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        delegate?.detailDidChange(sender: pickerView)
    }
    
}
