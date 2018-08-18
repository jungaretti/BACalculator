//
//  DrinkManager.swift
//  BACalculator
//
//  Created by James Ungaretti on 8/17/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import DrinkKit
import Foundation

/// A persistent data manager for the drinks logged into BACalculator.
class DrinkManager: DiskManager<[Drink]> {
    
    private var _drinks: [Drink]?
    /// The `Drink`s managed by the `DrinkManager`, sorted by consumption date.
    var drinks: [Drink]? {
        return _drinks
    }
    
    /// The default `DrinkManager`.
    static var `default` = DrinkManager(fileURL: FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!.appendingPathComponent("Drinks").appendingPathExtension("json"))
    
    /// Log a new `Drink` and save the new information to disk.
    ///
    /// - Parameter newDrink: The new `Drink`.
    func logDrink(_ newDrink: Drink) {
        // Initialize an empty drinks array if needed
        if _drinks == nil {
            _drinks = [Drink]()
        }
        // Determine if the drinks array must be sorted
        let drinksAreSorted: Bool
        if let lastDrink = _drinks!.last {
            drinksAreSorted = lastDrink.consumptionDate <= newDrink.consumptionDate
        } else {
            drinksAreSorted = true
        }
        // Append the new drink and sort if needed
        _drinks!.append(newDrink)
        if !(drinksAreSorted) { _drinks!.sortByDate() }
        // Save the new drink array to disk
        saveToDisk(_drinks!)
    }
    
    /// Remove a `Drink` at a certain index.
    ///
    /// - Parameter index: The index of the `Drink` to remove in `drinks`.
    func removeDrink(atIndex index: Int) {
        if _drinks != nil {
            _drinks!.remove(at: index)
            saveToDisk(_drinks!)
        }
    }
    
    /// Remove all `Drink`s.
    func removeAllDrinks() {
        if _drinks != nil {
            _drinks!.removeAll()
            saveToDisk(_drinks!)
        }
    }
    
}
