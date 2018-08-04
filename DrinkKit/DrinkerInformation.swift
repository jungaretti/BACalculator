//
//  DrinkerInformation.swift
//  DrinkKit
//
//  Created by James Ungaretti on 7/24/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import Foundation

/// Information about a drinker.
public struct DrinkerInformation: Codable {
    
    /// The weight of the drinker.
    public var weight: Measurement<UnitMass>
    /// The sex of the drinker.
    public var sex: DrinkerSex
    /// The alcohol metabolism of the drinker.
    public var alcoholMetabolism: DrinkerAlcoholMetabolism
    
    /// The volume of water in a drinker.
    var waterVolume: Measurement<UnitVolume> {
        let weightKilograms = weight.converted(to: UnitMass.kilograms).value
        let waterLiters = weightKilograms * sex.waterComposition
        let waterVolume = Measurement(value: waterLiters, unit: UnitVolume.liters)
        return waterVolume
    }
    
    /// Create a `DrinkerInformation` with a specific weight, sex, and alcohol metabolism.
    ///
    /// - Parameters:
    ///   - weight: The weight of the drinker.
    ///   - sex: The sex of the drinker.
    ///   - alcoholMetabolism: The alcohol metabolism of the drinker.
    public init(weight: Measurement<UnitMass>, sex: DrinkerSex, alcoholMetabolism: DrinkerAlcoholMetabolism) {
        self.weight = weight
        self.sex = sex
        self.alcoholMetabolism = alcoholMetabolism
    }
    
}
