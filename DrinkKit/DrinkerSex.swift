//
//  DrinkerSex.swift
//  DrinkKit
//
//  Created by James Ungaretti on 7/24/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import Foundation

/// Constants describing the biological sex of a drinker.
public enum DrinkerSex {
    
    case male
    case female
    
    /// The bodyMass:waterMass ratio of a drinker.
    var waterComposition: Double {
        switch self {
        case .male:
            return 0.58
        case .female:
            return 0.49
        }
    }
    /// A description of the `DrinkerSex` with capitilization.
    public var description: String {
        switch self {
        case .male:
            return "Male"
        case .female:
            return "Female"
        }
    }
    
}
