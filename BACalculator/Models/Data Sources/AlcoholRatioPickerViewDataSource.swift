//
//  AlcoholRatioPickerViewDataSource.swift
//  BACalculator
//
//  Created by James Ungaretti on 7/30/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import Foundation
import UIKit

class AlcoholRatioPickerViewDataSource: CustomSizePickerViewDataSource {
    
    static let alcoholRatios: [Double] = Array(1...200).map({ Double($0) / 2.0 })
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return AlcoholRatioPickerViewDataSource.alcoholRatios.count
    }
        
}
