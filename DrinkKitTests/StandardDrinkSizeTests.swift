//
//  StandardDrinkSizeTests.swift
//  DrinkKitTests
//
//  Created by James Ungaretti on 7/24/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import XCTest
@testable import DrinkKit

class StandardDrinkSizeTests: XCTestCase {
    
    var testStandardDrinks: Double!
    
    override func setUp() {
        super.setUp()
        testStandardDrinks = 1.0
    }
    
    override func tearDown() {
        testStandardDrinks = nil
        super.tearDown()
    }
    
    func test_init() {
        let standardDrinkSize = StandardDrinkSize(standardDrinks: testStandardDrinks)
        XCTAssert(standardDrinkSize.standardDrinks == testStandardDrinks, "StandardDrinkSize did not initialize standardDrinks properly.")
    }
    
    func test_init_invalid() {
        testStandardDrinks = -1.0
        let standardDrinkSize = StandardDrinkSize(standardDrinks: testStandardDrinks)
        XCTAssert(standardDrinkSize.standardDrinks == 0.0, "StandardDrinkSize did not initialize standardDrinks properly.")
    }
    
    func test_alcoholMass() {
        let standardDrinkSize = StandardDrinkSize(standardDrinks: 1.0)
        XCTAssert(standardDrinkSize.alcoholMass == Measurement(value: 14.0, unit: UnitMass.grams))
    }
    
    func test_isEmpty_false() {
        let standardDrinkSize = StandardDrinkSize(standardDrinks: 1.0)
        XCTAssertFalse(standardDrinkSize.isEmpty)
    }
    
    func test_isEmpty_true() {
        let standardDrinkSize = StandardDrinkSize(standardDrinks: 0.0)
        XCTAssertTrue(standardDrinkSize.isEmpty)
    }
    
}
