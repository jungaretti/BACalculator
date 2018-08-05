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
    
}
