//
//  DrinkSize.swift
//  DrinkKit
//
//  Created by James Ungaretti on 7/24/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import Foundation

/// A measurement of an alcoholic drink's size.
public protocol DrinkSize: Codable {
    
    /// The mass of alcohol in a drink.
    var alcoholMass: Measurement<UnitMass> { get }
    /// A description of the `DrinkSize`.
    var description: String { get }
    /// A Boolean value that indicates if the drink is empty.
    var isEmpty: Bool { get }
    
    /// A description of the `DrinkSize` expressed in units of a certain `DrinkType.`
    ///
    /// - Parameter type: A `DrinkType` to use for determining units.
    /// - Returns: A description of the `DrinkSize`.
    func description(forType type: DrinkType) -> String
    
}
