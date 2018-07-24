//
//  DrinkKit.swift
//  DrinkKit
//
//  Created by James Ungaretti on 7/24/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import Foundation

/// A measure of blood alcohol content.
public typealias BloodAlcoholContent = Double

public extension Array where Element == Drink {
    
    /// Sort an `Array` of `Drink`s by consumption date.
    public mutating func sortByDate() {
        self.sort(by: {$0.consumptionDate < $1.consumptionDate})
    }
    
    /// Sort an `Array` of `Drink`s by consumption date.
    ///
    /// - Returns: A sorted array of `Drink`s.
    public func sortedByDate() -> [Drink] {
        return self.sorted(by: {$0.consumptionDate < $1.consumptionDate})
    }
    
}
