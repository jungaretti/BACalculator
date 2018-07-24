//
//  DrinkerInformation.swift
//  DrinkKit
//
//  Created by James Ungaretti on 7/24/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import Foundation

/// Information about a drinker.
public struct DrinkerInformation {
    
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

/// Constants describing the biological sex of a drinker.
public enum DrinkerSex {
    
    case male
    case female
    
    /// The bodyMass:waterMass ratio of a drinker.
    var waterComposition: Double {
        switch self {
        case .male:
            return 0.58
        case .female:
            return 0.49
        }
    }
    
}

/// Constants describing the alcohol metabolism of a drinker. Alcohol metabolism is influenced by a drinker's frequency and quantity of alcohol consumption.
public enum DrinkerAlcoholMetabolism {
    
    case belowAverage
    case average
    case aboveAverage
    
    /// The measure of how much alcohol is metabolized from a drinker's blood each hour.
    var hourlyAlcoholMetabolism: Double {
        switch self {
        case .belowAverage:
            return 0.012
        case .average:
            return 0.017
        case .aboveAverage:
            return 0.02
        }
    }
    
}
