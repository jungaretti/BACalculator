//
//  DrinkerAlcoholMetabolism.swift
//  DrinkKit
//
//  Created by James Ungaretti on 7/24/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import Foundation

/// Constants describing the alcohol metabolism of a drinker. Alcohol metabolism is influenced by a drinker's frequency and quantity of alcohol consumption.
public enum DrinkerAlcoholMetabolism {
    
    case belowAverage
    case average
    case aboveAverage
    
    /// The measure of how much alcohol is metabolized from a drinker's blood each hour.
    var hourlyAlcoholMetabolism: BloodAlcoholContent {
        switch self {
        case .belowAverage:
            return 0.012
        case .average:
            return 0.017
        case .aboveAverage:
            return 0.02
        }
    }
    
}
