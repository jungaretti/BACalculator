//
//  VolumePickerViewDelegate.swift
//  BACalculator
//
//  Created by James Ungaretti on 7/30/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import Foundation
import UIKit

class VolumePickerViewDelegate: CustomSizePickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return "\(VolumePickerViewDataSource.values[row])"
        case 1:
            return "\(VolumePickerViewDataSource.units[row].symbol)"
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let value = VolumePickerViewDataSource.values[pickerView.selectedRow(inComponent: 0)]
        let unit = VolumePickerViewDataSource.units[pickerView.selectedRow(inComponent: 1)]
        let measurement = Measurement(value: value, unit: unit)
        detailTextLabel.text = measurement.description
        attributeOptionDelegate.volumeAttributeDidChange(sender: pickerView)
    }
    
}
