//
//  AlcoholCalculator.swift
//  DrinkKit
//
//  Created by James Ungaretti on 7/24/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import Foundation

/// A calculator for operations relating to alcohol and BAC.
public struct AlcoholCalculator {
    
    /// The ratio of water in blood.
    static let waterCompositionRatioBlood = 0.806
    
    /// The drinker information to use for calculations.
    public var drinkerInformation: DrinkerInformation
    /// The Safe Mode setting. When Safe Mode is enabled, a conservative alcohol metabolism is used in calculations.
    public var safeMode: Bool?
    
    /// Create an `AlcoholCalculator` for a specific drinker.
    ///
    /// - Parameter drinkerInformation: Information about the drinker using the `AlcoholCalculator`.
    public init(drinkerInformation: DrinkerInformation) {
        self.drinkerInformation = drinkerInformation
    }
    
    /// Create an `AlcoholCalculator` for a specific drinker and specify a Safe Mode setting.
    ///
    /// - Parameters:
    ///   - drinkerInformation: Information about the drinker using the `AlcoholCalculator`.
    ///   - safeMode: The setting for Safe Mode. When Safe Mode is enabled, a conservative alcohol metabolism is used in calculations.
    public init(drinkerInformation: DrinkerInformation, safeMode: Bool) {
        self.drinkerInformation = drinkerInformation
        self.safeMode = safeMode
    }
    
    /// Calculate the impact of a drink on BAC.
    ///
    /// - Parameter drink: The `Drink` to determine the impact of.
    /// - Returns: The impact of the `Drink` on BAC.
    public func impact(of drink: Drink) -> BloodAlcoholContent {
        let alcoholConsumedGrams = drink.size.alcoholMass.converted(to: UnitMass.grams).value
        // Determine the amount of alcohol absorbed into water, alcohol(g)/water(mL)
        let alcoholGramsOverWaterML = alcoholConsumedGrams / self.drinkerInformation.waterVolume.converted(to: UnitVolume.milliliters).value
        // Determine the amount of alcohol absorbed into blood, alcohol(g)/blood(mL)
        let alcoholGramsOverBloodML = alcoholGramsOverWaterML * AlcoholCalculator.waterCompositionRatioBlood
        return alcoholGramsOverBloodML * 100.0 // Convert to grams percent
    }
    
    /// Calculate the amount of alcohol metabolized over a certain `TimeInterval`. This value represents how much BAC would decrease over a certain amount of time.
    ///
    /// This calculation respects the `safeMode` setting of the `AlcoholCalculator`.
    ///
    /// - Parameter timeInterval: The `TimeInterval` to metabolize alcohol over.
    /// - Returns: The amount of alcohol metabolized over the `TimeInterval`.
    public func alcoholMetabolized(over timeInterval: TimeInterval) -> BloodAlcoholContent {
        let alcoholMetabolism: DrinkerAlcoholMetabolism
        if let safeMode = self.safeMode, safeMode == true {
            alcoholMetabolism = DrinkerAlcoholMetabolism.belowAverage
        } else {
            alcoholMetabolism = drinkerInformation.alcoholMetabolism
        }
        let hours = timeInterval / 3600.0
        return alcoholMetabolism.hourlyAlcoholMetabolism * hours
    }
    
    /// Calculate BAC at a certain date after consuming a collection of `Drink`s. BAC is calculated by iterating over a `[Drink]` from oldest drink to most recent drink.
    ///
    /// This calculation respects the `safeMode` setting of the `AlcoholCalculator`.
    ///
    /// - Parameters:
    ///   - date: The `Date` to calculate BAC at.
    ///   - drinks: The `Drink`s to use for calculating BAC.
    /// - Returns: The drinker's BAC at the specified `Date`.
    public func bloodAlcoholContent(atDate date: Date, afterDrinks drinks: [Drink]) -> BloodAlcoholContent {
        let sortedDrinks = drinks.sortedByDate()
        // Check that there have been drinks logged
        guard sortedDrinks.count > 0 else {
            return 0.0
        }
        // Check that the date comes after the first drink in the log
        guard date >= sortedDrinks.first!.consumptionDate else {
            return 0.0
        }
        // Calculate BAC along the way
        var bloodAlcoholContent: BloodAlcoholContent = 0.0
        bloodAlcoholContent += impact(of: sortedDrinks[0])
        let finalDrinkIndex: Int
        if sortedDrinks.count > 1 {
            var currentDrinkIndex = 1
            var previousDrinkIndex = 0
            while currentDrinkIndex < sortedDrinks.count && sortedDrinks[currentDrinkIndex].consumptionDate <= date {
                let timeIntervalSinceLastDrink = sortedDrinks[currentDrinkIndex].consumptionDate.timeIntervalSince(sortedDrinks[previousDrinkIndex].consumptionDate)
                let metabolized = alcoholMetabolized(over: timeIntervalSinceLastDrink)
                bloodAlcoholContent -= metabolized
                // If BAC dipped below zero, reset it to zero
                if bloodAlcoholContent < 0.0 {
                    bloodAlcoholContent = 0.0
                }
                let drinkImpact = impact(of: sortedDrinks[currentDrinkIndex])
                bloodAlcoholContent += drinkImpact
                // Advance currentDrinkIndex and previousDrinkIndex
                currentDrinkIndex += 1
                previousDrinkIndex += 1
            }
            finalDrinkIndex = currentDrinkIndex - 1
        } else {
            finalDrinkIndex = 0
        }
        // Calculate final BAC by accounting for metabolism
        let timeIntervalSinceLastDrink = date.timeIntervalSince(sortedDrinks[finalDrinkIndex].consumptionDate)
        let metabolized = alcoholMetabolized(over: timeIntervalSinceLastDrink)
        bloodAlcoholContent -= metabolized
        if bloodAlcoholContent < 0.0 {
            return 0.0
        }
        return bloodAlcoholContent
    }
    
}
