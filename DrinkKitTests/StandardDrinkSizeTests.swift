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
    
    func test_descriptionBasic() {
        let standardDrinkSize = StandardDrinkSize(standardDrinks: 1.0)
        let expectedDescription = "1 sd"
        XCTAssert(standardDrinkSize.description == expectedDescription, "StandardDrinkSize did not return the proper description. Expected \(expectedDescription), actual \(standardDrinkSize.description).")
    }
    
    func test_descriptionComplex() {
        let standardDrinkSize = StandardDrinkSize(standardDrinks: 1.2224)
        let expectedDescription = "1.2 sd"
        XCTAssert(standardDrinkSize.description == expectedDescription, "StandardDrinkSize did not return the proper description. Expected \(expectedDescription), actual \(standardDrinkSize.description).")
    }
    
    func test_descriptionForBeerBasicSingle() {
        let standardDrinkSize = StandardDrinkSize(standardDrinks: 1.0)
        let drinkType = DrinkType.beer
        let expectedDescription = "1 can"
        XCTAssert(standardDrinkSize.description(forType: drinkType) == expectedDescription, "StandardDrinkSize did not return the proper description for a type of drink. Expected \(expectedDescription), actual \(standardDrinkSize.description(forType: drinkType)).")
    }
    
    func test_descriptionForBeerBasicMultiple() {
        let standardDrinkSize = StandardDrinkSize(standardDrinks: 2.4)
        let drinkType = DrinkType.beer
        let expectedDescription = "2.4 cans"
        XCTAssert(standardDrinkSize.description(forType: drinkType) == expectedDescription, "StandardDrinkSize did not return the proper description for a type of drink. Expected \(expectedDescription), actual \(standardDrinkSize.description(forType: drinkType)).")
    }
    
    func test_descriptionForBeerComplex() {
        let standardDrinkSize = StandardDrinkSize(standardDrinks: 1.442)
        let drinkType = DrinkType.beer
        let expectedDescription = "1.4 cans"
        XCTAssert(standardDrinkSize.description(forType: drinkType) == expectedDescription, "StandardDrinkSize did not return the proper description for a type of drink. Expected \(expectedDescription), actual \(standardDrinkSize.description(forType: drinkType)).")
    }
    
    func test_descriptionForWineBasicSingle() {
        let standardDrinkSize = StandardDrinkSize(standardDrinks: 1.0)
        let drinkType = DrinkType.wine
        let expectedDescription = "1 glass"
        XCTAssert(standardDrinkSize.description(forType: drinkType) == expectedDescription, "StandardDrinkSize did not return the proper description for a type of drink. Expected \(expectedDescription), actual \(standardDrinkSize.description(forType: drinkType)).")
    }
    
    func test_descriptionForWineBasicMultiple() {
        let standardDrinkSize = StandardDrinkSize(standardDrinks: 2.4)
        let drinkType = DrinkType.wine
        let expectedDescription = "2.4 glasses"
        XCTAssert(standardDrinkSize.description(forType: drinkType) == expectedDescription, "StandardDrinkSize did not return the proper description for a type of drink. Expected \(expectedDescription), actual \(standardDrinkSize.description(forType: drinkType)).")
    }
    
    func test_descriptionForWineComplex() {
        let standardDrinkSize = StandardDrinkSize(standardDrinks: 1.442)
        let drinkType = DrinkType.wine
        let expectedDescription = "1.4 glasses"
        XCTAssert(standardDrinkSize.description(forType: drinkType) == expectedDescription, "StandardDrinkSize did not return the proper description for a type of drink. Expected \(expectedDescription), actual \(standardDrinkSize.description(forType: drinkType)).")
    }
    
    func test_descriptionForLiquorBasicSingle() {
        let standardDrinkSize = StandardDrinkSize(standardDrinks: 1.0)
        let drinkType = DrinkType.liquor
        let expectedDescription = "1 shot"
        XCTAssert(standardDrinkSize.description(forType: drinkType) == expectedDescription, "StandardDrinkSize did not return the proper description for a type of drink. Expected \(expectedDescription), actual \(standardDrinkSize.description(forType: drinkType)).")
    }
    
    func test_descriptionForLiquorBasicMultiple() {
        let standardDrinkSize = StandardDrinkSize(standardDrinks: 2.4)
        let drinkType = DrinkType.liquor
        let expectedDescription = "2.4 shots"
        XCTAssert(standardDrinkSize.description(forType: drinkType) == expectedDescription, "StandardDrinkSize did not return the proper description for a type of drink. Expected \(expectedDescription), actual \(standardDrinkSize.description(forType: drinkType)).")
    }
    
    func test_descriptionForLiquorComplex() {
        let standardDrinkSize = StandardDrinkSize(standardDrinks: 1.442)
        let drinkType = DrinkType.liquor
        let expectedDescription = "1.4 shots"
        XCTAssert(standardDrinkSize.description(forType: drinkType) == expectedDescription, "StandardDrinkSize did not return the proper description for a type of drink. Expected \(expectedDescription), actual \(standardDrinkSize.description(forType: drinkType)).")
    }
    
    func test_descriptionForDefaultBasicSingle() {
        let standardDrinkSize = StandardDrinkSize(standardDrinks: 1.0)
        let drinkType = DrinkType.mixed
        let expectedDescription = "1 standard drink"
        XCTAssert(standardDrinkSize.description(forType: drinkType) == expectedDescription, "StandardDrinkSize did not return the proper description for a type of drink. Expected \(expectedDescription), actual \(standardDrinkSize.description(forType: drinkType)).")
    }
    
    func test_descriptionForDefaultBasicMultiple() {
        let standardDrinkSize = StandardDrinkSize(standardDrinks: 2.4)
        let drinkType = DrinkType.mixed
        let expectedDescription = "2.4 standard drinks"
        XCTAssert(standardDrinkSize.description(forType: drinkType) == expectedDescription, "StandardDrinkSize did not return the proper description for a type of drink. Expected \(expectedDescription), actual \(standardDrinkSize.description(forType: drinkType)).")
    }
    
    func test_descriptionForDefaultComplex() {
        let standardDrinkSize = StandardDrinkSize(standardDrinks: 1.442)
        let drinkType = DrinkType.mixed
        let expectedDescription = "1.4 standard drinks"
        XCTAssert(standardDrinkSize.description(forType: drinkType) == expectedDescription, "StandardDrinkSize did not return the proper description for a type of drink. Expected \(expectedDescription), actual \(standardDrinkSize.description(forType: drinkType)).")
    }
    
}
