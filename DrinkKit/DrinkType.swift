//
//  DrinkType.swift
//  DrinkKit
//
//  Created by James Ungaretti on 7/24/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import Foundation

/// Constants describing different types of alcoholic beverages.
public enum DrinkType: String, Codable {
    
    case beer = "beer"
    case wine = "wine"
    case liquor = "liquor"
    case mixed = "mixed"
    
    /// A description of the `DrinkType` with capitilization.
    public var description: String {
        switch self {
        case .beer:
            return "Beer"
        case .wine:
            return "Wine"
        case .liquor:
            return "Liquor"
        case .mixed:
            return "Mixed"
        }
    }
    
    /// Determine the appropriate unit for the `DrinkType` for a certain quantity of drinks.
    ///
    /// - Parameter quantity: The quantity of drinks for the `DrinkType`.
    /// - Returns: The appropriate unit of the `DrinkType`.
    public func unit(forQuantity quantity: Double) -> String {
        if quantity == 1.0 {
            switch self {
            case .beer:
                return "can"
            case .wine:
                return "glass"
            case .liquor:
                return "shot"
            default:
                return "standard drink"
            }
        } else {
            switch self {
            case .beer:
                return "cans"
            case .wine:
                return "glasses"
            case .liquor:
                return "shots"
            default:
                return "standard drinks"
            }
        }
    }
    
}
