//
//  Drink.swift
//  DrinkKit
//
//  Created by James Ungaretti on 7/24/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import Foundation

/// An alcoholic drink.
public struct Drink {
    
    /// The type of alcoholic beverage.
    public var type: DrinkType
    /// The consumption date of the drink.
    public var consumptionDate: Date
    /// The size of the drink
    public var size: DrinkSize
    
    /// Create a `Drink` with a specific type, consumption date, and size.
    ///
    /// - Parameters:
    ///   - type: The type of alcoholic beverage.
    ///   - consumptionDate: The consumption date of the drink.
    ///   - size: The size of the drink.
    public init(type: DrinkType, consumptionDate: Date, size: DrinkSize) {
        self.type = type
        self.consumptionDate = consumptionDate
        self.size = size
    }
    
}

extension Drink: Comparable {
    
    public static func < (lhs: Drink, rhs: Drink) -> Bool {
        return lhs.size.alcoholMass < rhs.size.alcoholMass
    }
    
    public static func == (lhs: Drink, rhs: Drink) -> Bool {
        return lhs.size.alcoholMass == rhs.size.alcoholMass
    }
    
}

extension Drink: Codable {
    
    /// Coding keys for `Drink`.
    private enum DrinkCodingKeys: String, CodingKey {
        
        case type
        case consumptionDate
        case size
        
    }
    
    /// Coding keys for instances that conform to `DrinkSize`.
    private enum DrinkSizeCodingKeys: String, CodingKey {
        
        case type
        case size
        
    }
    
    /// Constants describing the type of `DrinkSize` stored by the `Drink`.
    private enum DrinkSizeType: Int, Codable {
        
        case standard = 0
        case custom = 1
        
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: DrinkCodingKeys.self)
        // Decode basic information about the Drink
        self.type = try values.decode(DrinkType.self, forKey: .type)
        self.consumptionDate = try values.decode(Date.self, forKey: .consumptionDate)
        // Decode size information about the Drink
        let sizeValues = try values.nestedContainer(keyedBy: DrinkSizeCodingKeys.self, forKey: .size)
        let sizeType = try sizeValues.decode(DrinkSizeType.self, forKey: .type)
        switch sizeType {
        case .standard:
            self.size = try sizeValues.decode(StandardDrinkSize.self, forKey: .size)
        case .custom:
            self.size = try sizeValues.decode(CustomDrinkSize.self, forKey: .size)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: DrinkCodingKeys.self)
        // Encode basic information about the Drink
        try container.encode(self.type, forKey: .type)
        try container.encode(self.consumptionDate, forKey: .consumptionDate)
        // Encode size information about the Drink
        var sizeContainer = container.nestedContainer(keyedBy: DrinkSizeCodingKeys.self, forKey: .size)
        if let standardSize = self.size as? StandardDrinkSize {
            try sizeContainer.encode(DrinkSizeType.standard, forKey: .type)
            try sizeContainer.encode(standardSize, forKey: .size)
        } else if let customSize = self.size as? CustomDrinkSize {
            try sizeContainer.encode(DrinkSizeType.custom, forKey: .type)
            try sizeContainer.encode(customSize, forKey: .size)
        } else {
            throw EncodingError.invalidValue(self.size, .init(codingPath: [DrinkCodingKeys.size, DrinkSizeCodingKeys.type], debugDescription: "The DrinkSize could not be encoded."))
        }
    }
    
}

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
