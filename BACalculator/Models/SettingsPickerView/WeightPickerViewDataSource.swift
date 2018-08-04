//
//  WeightPickerViewDataSource.swift
//  BACalculator
//
//  Created by James Ungaretti on 7/31/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import Foundation
import UIKit

class WeightPickerViewDataSource: SettingsPickerViewDataSource {
    
    static let values: [Double] = Array(1...800).map({ Double($0) })
    static let units: [UnitMass] = [UnitMass.pounds, UnitMass.kilograms]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return WeightPickerViewDataSource.values.count
        case 1:
            return WeightPickerViewDataSource.units.count
        default:
            return 0
        }
    }
    
}
