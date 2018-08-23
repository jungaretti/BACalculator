//
//  AlcoholRatioPickerViewDelegateAlcoholRatioPickerViewDelegate.swift
//  BACalculator
//
//  Created by James Ungaretti on 7/30/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import Foundation
import UIKit

class AlcoholRatioPickerViewDelegate: CustomSizePickerViewDelegate {
    
    private let numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 1
        numberFormatter.maximumFractionDigits = 1
        return numberFormatter
    }()
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let formattedValue = numberFormatter.string(from: NSNumber(value: AlcoholRatioPickerViewDataSource.alcoholRatios[row]))
        return "\(formattedValue!) %"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        detailTextLabel.text = self.pickerView(pickerView, titleForRow: row, forComponent: 0)
        attributeOptionDelegate.alcoholRatioAttributeDidChange(sender: pickerView)
    }
    
}
