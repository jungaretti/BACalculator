//
//  DrinkAttributeManager.swift
//  BACalculator
//
//  Created by James Ungaretti on 7/30/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import DrinkKit

struct DrinkAttributeManager {
    
    static let types: [DrinkType] = [.beer, .wine, .liquor, .mixed]
    static let standardSizes: [Int] = Array(1...5)
    
    static func icon(forType type: DrinkType) -> UIImage? {
        switch type {
        case .beer:
            return UIImage(named: "Beer")
        case .wine:
            return UIImage(named: "Wine")
        case .liquor:
            return UIImage(named: "Liquor")
        case .mixed:
            return UIImage(named: "Mixed")
        }
    }
    
}
