//
//  CalculationDelegate.swift
//  BACalculator
//
//  Created by James Ungaretti on 8/12/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import Foundation

/// The `CalculationDelegate` protocol defines a set of behaviors for objects that calculate BAC repeatedly.
protocol CalculationDelegate: class {
    
    /// Tells the delegate that a variable in the blood alcohol content calculation was changed
    func calculationVariableDidChange()
    
}
