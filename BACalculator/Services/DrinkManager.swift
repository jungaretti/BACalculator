//
//  DrinkManager.swift
//  BACalculator
//
//  Created by James Ungaretti on 8/12/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import Foundation
import DrinkKit

/// The persistent data manager for drinks in BACalculator.
class DrinkManager: DiskManager<[Drink]> {
    
    /// The default `DrinkManager`.
    static var `default` = DrinkManager(fileURL: FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!.appendingPathComponent("Drinks").appendingPathExtension("json"))
    
    /// The `[Drink]` managed by the `DrinkManager`.
    var drinks: [Drink]? {
        return managed
    }
    
    /// Log a new `Drink` and save the drinks.
    ///
    /// - Parameter newDrink: The new `Drink` to log.
    func log(drink newDrink: Drink) {
        if managed == nil {
            managed = [Drink]()
        }
        managed!.append(newDrink)
        managed!.sortByDate()
        saveToDisk()
    }
    
    /// Remove a `Drink` from a certain index and save the drinks.
    ///
    /// - Parameter index: The index of the `Drink` to remove.
    func remove(atIndex index: Int) {
        managed?.remove(at: index)
        saveToDisk()
    }
    
    /// Remove all `Drink`s and save an empty file.
    func removeAll() {
        managed?.removeAll()
        saveToDisk()
    }
    
}
