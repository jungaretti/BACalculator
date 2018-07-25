//
//  DrinkerInformationManager.swift
//  BACalculator
//
//  Created by James Ungaretti on 7/24/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import DrinkKit
import Foundation

class DrinkerInformationManager {
    
    static var drinkerInformation: DrinkerInformation = DrinkerInformation(weight: Measurement(value: 200, unit: UnitMass.pounds), sex: .male, alcoholMetabolism: .average)
    
}
