//
//  MetabolismCalculatorTests.swift
//  DrinkKitTests
//
//  Created by James Ungaretti on 8/14/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import XCTest
@testable import DrinkKit

class MetabolismCalculatorTests: XCTestCase {
    
    let testAlcoholMetabolism = DrinkerAlcoholMetabolism.average
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_metabolized() {
        let metabolismCalculator = MetabolismCalculator(alcoholMetabolism: testAlcoholMetabolism)
        let timeInterval = 5400.0
        let expectedAlcoholMetabolized = 0.0255
        let difference = abs(metabolismCalculator.alcoholMetabolized(over: timeInterval) - expectedAlcoholMetabolized)
        XCTAssert(difference < 0.005, "Alcohol metabolized was not calculated properly. Expected \(expectedAlcoholMetabolized), actual \(metabolismCalculator.alcoholMetabolized(over: timeInterval)).")
    }
    
    func test_metabolized_safeMode() {
        var metabolismCalculator = MetabolismCalculator(alcoholMetabolism: testAlcoholMetabolism)
        metabolismCalculator.safeMode = true
        let timeInterval = 7200.0
        let expectedAlcoholMetabolized = 0.024
        let difference = abs(metabolismCalculator.alcoholMetabolized(over: timeInterval) - expectedAlcoholMetabolized)
        XCTAssert(difference < 0.005, "Alcohol metabolized was not calculated properly. Expected \(expectedAlcoholMetabolized), actual \(metabolismCalculator.alcoholMetabolized(over: timeInterval)).")
    }

}
