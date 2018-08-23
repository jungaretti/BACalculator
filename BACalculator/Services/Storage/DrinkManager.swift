//
//  DrinkManager.swift
//  BACalculator
//
//  Created by James Ungaretti on 8/17/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import DrinkKit
import Foundation
import os.log

/// A persistent data manager for the drinks logged into BACalculator.
class DrinkManager: DiskManager<[Drink]> {
    
    /// The `[Drink]` managed by the `DrinkManager`. The `[Drink]` is **not sorted** in any particular order.
    var drinks: [Drink]! {
        didSet {
            saveToDisk(drinks)
        }
    }
    
    /// The default `DrinkManager`.
    static var `default` = DrinkManager(fileURL: FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!.appendingPathComponent("Drinks").appendingPathExtension("json"))
    
    /// Create a `DrinkManager` for a certain `URL` and attempt to load any existing data.
    ///
    /// - Parameter fileURL: The `URL` of the file to use for persistent storage.
    override init(fileURL: URL) {
        super.init(fileURL: fileURL)
        if let drinksFromDisk = loadFromDisk() {
            drinks = drinksFromDisk
        } else {
            drinks = [Drink]()
        }
    }
    
}
