//
//  MetabolismCalculator.swift
//  DrinkKit
//
//  Created by James Ungaretti on 8/14/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import Foundation

/// A calculator for operations relating to alcohol metabolism.
struct MetabolismCalculator: Calculator {
    
    /// When safe mode is enabled, a conservative rate of alcohol metabolism is used for calculations. The default value is `false`.
    var safeMode: Bool
    /// The drinker's alcohol metabolism.
    var alcoholMetabolism: DrinkerAlcoholMetabolism
    
    /// Create a `MetabolismCalculator` for a certain `DrinkerAlcoholMetabolism`.
    init(alcoholMetabolism: DrinkerAlcoholMetabolism) {
        self.alcoholMetabolism = alcoholMetabolism
        self.safeMode = false
    }
    
    /// Calculate the amount of alcohol metabolized over a certain `TimeInterval`. This value represents how much a drinker's BAC would decrease over the `TimeInterval`.
    ///
    /// - Parameter timeInterval: The `TimeInterval` to metabolize alcohol over.
    /// - Returns: The amount of alcohol metabolized over the `TimeInterval`.
    public func alcoholMetabolized(over timeInterval: TimeInterval) -> BloodAlcoholContent {
        let alcoholMetabolism: DrinkerAlcoholMetabolism
        if safeMode {
            alcoholMetabolism = DrinkerAlcoholMetabolism.belowAverage
        } else {
            alcoholMetabolism = self.alcoholMetabolism
        }
        let hours = timeInterval / 3600.0
        return alcoholMetabolism.hourlyAlcoholMetabolism * hours
    }
    
}
