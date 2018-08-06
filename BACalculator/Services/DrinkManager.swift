//
//  DrinkManager.swift
//  BACalculator
//
//  Created by James Ungaretti on 7/24/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import DrinkKit
import Foundation
import os.log

/// A persistent storage manager for `Drink`s.
class DrinkManager: DiskManager<[Drink]> {
    
    /// The default `DrinkManager`. This `DrinkManager` saves information to `Drinks.json` in the Application Support directory.
    static var `default` = DrinkManager(fileURL: FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!.appendingPathComponent("Drinks").appendingPathExtension("json"))
    
    /// The `[Drink]` managed by the `DrinkManager`, or an empty `[Drink]` if the drinks cannot be loaded from persistent storage.
    var drinks: [Drink] {
        if managedData == nil {
            managedData = [Drink]()
            os_log("DrinkManager initialized managedData.")
            saveToDisk()
        }
        return managedData!
    }
    
    /// Log a new `Drink`.
    ///
    /// - Parameter newDrink: The new `Drink` to log.
    func logDrink(_ newDrink: Drink) {
        if managedData != nil {
            // Determine if the [Drink] needs sorting
            let needsSorting: Bool
            if let lastDrink = managedData!.last {
                if lastDrink.consumptionDate > newDrink.consumptionDate { needsSorting = true }
                else { needsSorting = false }
            } else { needsSorting = false }
            // Append the newDrink and sort if needed
            managedData!.append(newDrink)
            if needsSorting { managedData!.sortByDate() }
        } else {
            managedData = [newDrink]
        }
        saveToDisk()
    }
    
    /// Remove a `Drink` at a certain index.
    ///
    /// - Parameter index: The index of the `Drink` to remove.
    func removeDrink(atIndex index: Int) {
        managedData?.remove(at: index)
        saveToDisk()
    }
    
    /// Remove all `Drink`s.
    func removeAllDrinks() {
        managedData?.removeAll()
        saveToDisk()
    }
    
}
