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
    
}
