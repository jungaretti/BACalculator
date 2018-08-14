//
//  BloodAlcoholCalculator.swift
//  DrinkKit
//
//  Created by James Ungaretti on 7/24/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import Foundation

/// A calculator for operations relating to blood alcohol content.
public struct BloodAlcoholCalculator: Calculator {
    
    /// The ratio of water in blood.
    static let waterCompositionRatioBlood = 0.806
    
    /// The drinker information to use for calculations.
    public var drinkerInformation: DrinkerInformation
    
    /// Create a `BloodAlcoholCalculator` for a specific drinker.
    ///
    /// - Parameter drinkerInformation: Information about the drinker using the `BloodAlcoholCalculator`.
    public init(drinkerInformation: DrinkerInformation) {
        self.drinkerInformation = drinkerInformation
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
        let alcoholGramsOverBloodML = alcoholGramsOverWaterML * BloodAlcoholCalculator.waterCompositionRatioBlood
        return alcoholGramsOverBloodML * 100.0 // Convert to grams percent
    }

    /// Calculate `BloodAlcoholContent`.
    ///
    /// - Parameters:
    ///   - date: The `Date` to calculate `BloodAlcoholContent` at.
    ///   - drinks: The `[Drink]` to use for `BloodAlcoholContent` calculation.
    /// - Returns: The `BloodAlcoholContent` at the specified `Date.
    public func bloodAlcoholContent(atDate date: Date, afterDrinks drinks: [Drink]) -> BloodAlcoholContent {
        return bloodAlcoholContent(atDate: date, afterDrinks: drinks, safeMode: false)
    }

    /// Calculate `BloodAlcoholContent` and specify a safe mode preference.
    ///
    /// - Parameters:
    ///   - date: The `Date` to calculate `BloodAlcoholContent` at.
    ///   - drinks: The `[Drink]` to use for `BloodAlcoholContent` calculation.
    ///   - safeMode: The safe mode preference.
    /// - Returns: The `BloodAlcoholContent` at the specified `Date.
    public func bloodAlcoholContent(atDate date: Date, afterDrinks drinks: [Drink], safeMode: Bool) -> BloodAlcoholContent {
        let sortedDrinks = drinks.sortedByDate()
        var metabolismCalculator = MetabolismCalculator(alcoholMetabolism: drinkerInformation.alcoholMetabolism)
        metabolismCalculator.safeMode = safeMode
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
                let metabolized = metabolismCalculator.alcoholMetabolized(over: timeIntervalSinceLastDrink)
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
        let metabolized = metabolismCalculator.alcoholMetabolized(over: timeIntervalSinceLastDrink)
        bloodAlcoholContent -= metabolized
        if bloodAlcoholContent < 0.0 {
            return 0.0
        }
        return bloodAlcoholContent
    }
    
}
