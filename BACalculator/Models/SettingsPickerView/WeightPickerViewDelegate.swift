//
//  WeightPickerViewDelegate.swift
//  BACalculator
//
//  Created by James Ungaretti on 7/31/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import Foundation
import UIKit

class WeightPickerViewDelegate: SettingsPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return WeightPickerViewDataSource.values[row].description
        case 1:
            return WeightPickerViewDataSource.units[row].symbol
        default:
            return nil
        }
    }
    
    override func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedValue = WeightPickerViewDataSource.values[pickerView.selectedRow(inComponent: 0)]
        let selectedUnit = WeightPickerViewDataSource.units[pickerView.selectedRow(inComponent: 1)]
        DrinkerInformationManager.default.update(weight: Measurement(value: selectedValue, unit: selectedUnit))
        super.pickerView(pickerView, didSelectRow: row, inComponent: component)
    }
    
}
