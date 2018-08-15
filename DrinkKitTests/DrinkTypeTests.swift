//
//  DrinkTypeTests.swift
//  DrinkKitTests
//
//  Created by James Ungaretti on 8/14/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import XCTest
@testable import DrinkKit

class DrinkTypeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_description_beer() {
        let testType = DrinkType.beer
        let expectedDescription = "Beer"
        XCTAssert(testType.description == expectedDescription, "The DrinkType did not return the proper description. Expected \(expectedDescription), actual \(testType.description).")
    }
    
    func test_description_wine() {
        let testType = DrinkType.wine
        let expectedDescription = "Wine"
        XCTAssert(testType.description == expectedDescription, "The DrinkType did not return the proper description. Expected \(expectedDescription), actual \(testType.description).")
    }
    
    func test_description_liquor() {
        let testType = DrinkType.liquor
        let expectedDescription = "Liquor"
        XCTAssert(testType.description == expectedDescription, "The DrinkType did not return the proper description. Expected \(expectedDescription), actual \(testType.description).")
    }
    
    func test_description_mixed() {
        let testType = DrinkType.mixed
        let expectedDescription = "Mixed"
        XCTAssert(testType.description == expectedDescription, "The DrinkType did not return the proper description. Expected \(expectedDescription), actual \(testType.description).")
    }
    
    func test_unit_beerSingle() {
        let type = DrinkType.beer
        let quantity = 1.0
        let expectedUnit = "can"
        XCTAssert(type.unit(forQuantity: quantity) == expectedUnit, "The DrinkType did not return the proper unit for quanity \(quantity). Expected \(expectedUnit), actual \(type.unit(forQuantity: quantity)).")
    }
    
    func test_unit_beerMany() {
        let type = DrinkType.beer
        let quantity = 2.4
        let expectedUnit = "cans"
        XCTAssert(type.unit(forQuantity: quantity) == expectedUnit, "The DrinkType did not return the proper unit for quanity \(quantity). Expected \(expectedUnit), actual \(type.unit(forQuantity: quantity)).")
    }
    
    func test_unit_wineSingle() {
        let type = DrinkType.wine
        let quantity = Double(1)
        let expectedUnit = "glass"
        XCTAssert(type.unit(forQuantity: quantity) == expectedUnit, "The DrinkType did not return the proper unit for quanity \(quantity). Expected \(expectedUnit), actual \(type.unit(forQuantity: quantity)).")
    }
    
    func test_unit_wineMany() {
        let type = DrinkType.wine
        let quantity = 1.6818181
        let expectedUnit = "glasses"
        XCTAssert(type.unit(forQuantity: quantity) == expectedUnit, "The DrinkType did not return the proper unit for quanity \(quantity). Expected \(expectedUnit), actual \(type.unit(forQuantity: quantity)).")
    }
    
    func test_unit_liquorSingle() {
        let type = DrinkType.liquor
        let quantity = 1.0000000000000001
        let expectedUnit = "shot"
        XCTAssert(type.unit(forQuantity: quantity) == expectedUnit, "The DrinkType did not return the proper unit for quanity \(quantity). Expected \(expectedUnit), actual \(type.unit(forQuantity: quantity)).")
    }
    
    func test_unit_liquorMany() {
        let type = DrinkType.liquor
        let quantity = 0.4
        let expectedUnit = "shots"
        XCTAssert(type.unit(forQuantity: quantity) == expectedUnit, "The DrinkType did not return the proper unit for quanity \(quantity). Expected \(expectedUnit), actual \(type.unit(forQuantity: quantity)).")
    }
    
    func test_unit_defaultSingle() {
        let type = DrinkType.mixed
        let quantity = 1.0
        let expectedUnit = "standard drink"
        XCTAssert(type.unit(forQuantity: quantity) == expectedUnit, "The DrinkType did not return the proper unit for quanity \(quantity). Expected \(expectedUnit), actual \(type.unit(forQuantity: quantity)).")
    }
    
    func test_unit_defaultMany() {
        let type = DrinkType.mixed
        let quantity = 3.6
        let expectedUnit = "standard drinks"
        XCTAssert(type.unit(forQuantity: quantity) == expectedUnit, "The DrinkType did not return the proper unit for quanity \(quantity). Expected \(expectedUnit), actual \(type.unit(forQuantity: quantity)).")
    }
    
}
