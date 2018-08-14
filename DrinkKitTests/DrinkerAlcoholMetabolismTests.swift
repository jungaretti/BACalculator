//
//  DrinkerAlcoholMetabolismTests.swift
//  DrinkKitTests
//
//  Created by James Ungaretti on 8/14/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import XCTest
@testable import DrinkKit

class DrinkerAlcoholMetabolismTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_hourlyAlcoholMetabolism_belowAverage() {
        let testAlcoholMetabolism = DrinkerAlcoholMetabolism.belowAverage
        let expectedHourlyAlcoholMetabolism = 0.012
        XCTAssert(testAlcoholMetabolism.hourlyAlcoholMetabolism == expectedHourlyAlcoholMetabolism, "The DrinkerAlcoholMetabolsim did not return the expected hourlyAlcoholMetabolism. Expected \(expectedHourlyAlcoholMetabolism), actual \(testAlcoholMetabolism.hourlyAlcoholMetabolism).")
    }
    
    func test_hourlyAlcoholMetabolism_average() {
        let testAlcoholMetabolism = DrinkerAlcoholMetabolism.average
        let expectedHourlyAlcoholMetabolism = 0.017
        XCTAssert(testAlcoholMetabolism.hourlyAlcoholMetabolism == expectedHourlyAlcoholMetabolism, "The DrinkerAlcoholMetabolsim did not return the expected hourlyAlcoholMetabolism. Expected \(expectedHourlyAlcoholMetabolism), actual \(testAlcoholMetabolism.hourlyAlcoholMetabolism).")
    }
    
    func test_hourlyAlcoholMetabolism_aboveAverage() {
        let testAlcoholMetabolism = DrinkerAlcoholMetabolism.aboveAverage
        let expectedHourlyAlcoholMetabolism = 0.02
        XCTAssert(testAlcoholMetabolism.hourlyAlcoholMetabolism == expectedHourlyAlcoholMetabolism, "The DrinkerAlcoholMetabolsim did not return the expected hourlyAlcoholMetabolism. Expected \(expectedHourlyAlcoholMetabolism), actual \(testAlcoholMetabolism.hourlyAlcoholMetabolism).")
    }
    
}
