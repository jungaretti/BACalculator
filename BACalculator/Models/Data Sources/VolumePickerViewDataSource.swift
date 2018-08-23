//
//  VolumePickerViewDataSource.swift
//  BACalculator
//
//  Created by James Ungaretti on 7/30/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import Foundation
import UIKit

class VolumePickerViewDataSource: CustomSizePickerViewDataSource {
    
    static let values: [Double] = {
        let firstSequence = Array(1...5).map({ Double($0) / 2.0 })
        let secondSequence = Array(3...750).map({ Double($0) })
        return firstSequence + secondSequence
    }()
    static let units = [UnitVolume.fluidOunces, UnitVolume.milliliters]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return VolumePickerViewDataSource.values.count
        case 1:
            return VolumePickerViewDataSource.units.count
        default:
            return 0
        }
    }
    
}
