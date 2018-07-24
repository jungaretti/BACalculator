//
//  DrinkSize.swift
//  DrinkKit
//
//  Created by James Ungaretti on 7/24/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import Foundation

/// A measurement of an alcoholic drink's size.
public protocol DrinkSize {
    
    /// The mass of alcohol in a drink.
    var alcoholMass: Measurement<UnitMass> { get }
    /// A Boolean value that indicates if the drink is empty.
    var isEmpty: Bool { get }
    
}
