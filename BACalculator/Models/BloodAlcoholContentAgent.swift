//
//  BloodAlcoholContentAgent.swift
//  BACalculator
//
//  Created by James Ungaretti on 7/27/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import DrinkKit
import Foundation
import os.log

struct BloodAlcoholContentAgent {
    
    static var `default` = BloodAlcoholContentAgent()
    
    private var _offsetHours: Int
    private var _offsetTimeInterval: TimeInterval {
        return TimeInterval(3600 * offsetHours)
    }
    /// The number of hours to offset the `Date` by.
    var offsetHours: Int {
        return _offsetHours
    }
    /// The `NumberFormatter` to use for formatting the `BloodAlcoholContent`.
    var numberFormatter: NumberFormatter
    
    /// Create a `BloodAlcoholContentAgent`.
    init() {
        self.init(offsetHours: 0)
    }
    
    /// Create a `BloodAlcoholContentAgent` and specify a certain number of hours to offset the simulated time by.
    ///
    /// - Parameter offsetHours: The number of hours to offset the simulated time by.
    init(offsetHours: Int) {
        self._offsetHours = offsetHours
        self.numberFormatter = NumberFormatter()
        self.numberFormatter.numberStyle = .decimal
        self.numberFormatter.minimumFractionDigits = 2
        self.numberFormatter.maximumFractionDigits = 2
        self.numberFormatter.maximumIntegerDigits = 1
    }
    
    /// Increment or decrement the simulated time by a certain number of hours.
    ///
    /// - Parameter hours: The number of hours to add to `offsetHours`.
    mutating func adjustOffset(byHours hours: Int) {
        self._offsetHours += hours
    }
    
    /// Calculate BAC for the `Date` determine from `hoursOffset`. If `safeMode` is specified and `true`, a conservative alcohol metabolism is used in calculations.
    ///
    /// - Parameter safeMode: The Safe Mode preference. If `safeMode` is specified and `true`, a conservative alcohol metabolism is used in calculations.
    /// - Returns: `BloodAlcoholContent` measurement at the simulated date.
    func calculateBAC(safeMode: Bool?) -> BloodAlcoholContent {
        return calculateBAC(atDate: Date().addingTimeInterval(_offsetTimeInterval), safeMode: safeMode)
    }
    
    /// Calculate BAC for a certain `Date`. If `safeMode` is specified and `true`, a conservative alcohol metabolism is used in calculations.
    ///
    /// - Parameters:
    ///   - date: The `Date` to calculate BAC at.
    ///   - safeMode: The Safe Mode preference. If `safeMode` is specified and `true`, a conservative alcohol metabolism is used in calculations.
    /// - Returns: `BloodAlcoholContent` measurement at the specified `Date`.
    func calculateBAC(atDate date: Date, safeMode: Bool?) -> BloodAlcoholContent {
        var alcoholCalculator = AlcoholCalculator(drinkerInformation: DrinkerInformationManager.drinkerInformation)
        alcoholCalculator.safeMode = safeMode
        let bloodAlcoholContent = alcoholCalculator.bloodAlcoholContent(atDate: date, afterDrinks: DrinkManager.drinks)
        os_log("BAC was recalculated. %f at %@.", bloodAlcoholContent, date.description)
        return bloodAlcoholContent
    }
    
    /// Format a raw `BloodAlcoholContent` value to contain 2 decimal digits and 1 integer digit.
    ///
    /// - Parameter bloodAlcoholContent: The `BloodAlcoholContent` value to format.
    /// - Returns: A formatted version of the `BloodAlcoholContent`.
    func formatBloodAlcoholContent(_ bloodAlcoholContent: BloodAlcoholContent) -> String {
        return numberFormatter.string(from: NSNumber(value: bloodAlcoholContent))!
    }
    
}
