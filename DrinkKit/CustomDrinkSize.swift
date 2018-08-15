//
//  CustomDrinkSize.swift
//  DrinkKit
//
//  Created by James Ungaretti on 7/24/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import Foundation

/// A measurement of an alcoholic drink with a specific volume and alcohol ratio.
public struct CustomDrinkSize: DrinkSize {
    
    /// The specific gravity of alcohol.
    private static let alcoholSpecificGravity: Double = 0.79
    
    public var alcoholMass: Measurement<UnitMass> {
        let alcoholVolumeML = volume.converted(to: UnitVolume.milliliters).value * alcoholRatio
        let alcoholMassG = alcoholVolumeML * CustomDrinkSize.alcoholSpecificGravity
        return Measurement(value: alcoholMassG, unit: UnitMass.grams)
    }
    public var description: String {
        let volumeFormatter = MeasurementFormatter()
        volumeFormatter.numberFormatter.maximumFractionDigits = 1
        volumeFormatter.unitOptions = .providedUnit
        let alcoholRatioFormatter = NumberFormatter()
        alcoholRatioFormatter.numberStyle = .percent
        alcoholRatioFormatter.maximumFractionDigits = 2
        return "\(volumeFormatter.string(from: volume)), \(alcoholRatioFormatter.string(from: NSNumber(value: alcoholRatio))!) abv"
    }
    public var isEmpty: Bool {
        if volume.value == 0.0 || alcoholRatio == 0.0 { return true }
        return false
    }
    /// The volume of the drink.
    public var volume: Measurement<UnitVolume>
    /// The alcohol ratio (ABV) of the drink.
    public var alcoholRatio: Double
    
    /// Create a `CustomDrinkSize` with a specific volume and alcohol ratio.
    ///
    /// - Parameters:
    ///   - volume: The volume of the drink.
    ///   - alcoholRatio: The alcohol ratio (alcohol by volume) of the drink.
    public init(volume: Measurement<UnitVolume>, alcoholRatio: Double) {
        // Check that the drink's volume is greater than 0.0
        if volume.value > 0.0 { self.volume = volume }
        else { self.volume = Measurement(value: 0.0, unit: UnitVolume.milliliters) }
        // Check that the drink's alcohol ratio is greater than 0.0
        if alcoholRatio > 0.0 { self.alcoholRatio = alcoholRatio }
        else { self.alcoholRatio = 0.0 }
    }
    
    public func description(forType type: DrinkType) -> String {
        return description
    }
    
}
