//
//  CustomDrinkSizeTests.swift
//  DrinkKitTests
//
//  Created by James Ungaretti on 7/24/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import XCTest
@testable import DrinkKit

class CustomDrinkSizeTests: XCTestCase {
    
    var testVolume: Measurement<UnitVolume>!
    var testAlcoholRatio: Double!
    
    override func setUp() {
        super.setUp()
        testVolume = Measurement(value: 1.5, unit: UnitVolume.fluidOunces)
        testAlcoholRatio = 0.40
    }
    
    override func tearDown() {
        testVolume = nil
        testAlcoholRatio = nil
        super.tearDown()
    }
    
    func test_init() {
        let customDrinkSize = CustomDrinkSize(volume: testVolume, alcoholRatio: testAlcoholRatio)
        XCTAssert(customDrinkSize.volume == testVolume, "CustomDrinkSize did not initialize volume properly.")
        XCTAssert(customDrinkSize.alcoholRatio == testAlcoholRatio, "CustomDrinkSize did not initialize alcohol ratio properly.")
    }
    
    func test_init_invalid() {
        testVolume = Measurement(value: -1.0, unit: UnitVolume.milliliters)
        testAlcoholRatio = -0.40
        let customDrinkSize = CustomDrinkSize(volume: testVolume, alcoholRatio: testAlcoholRatio)
        XCTAssert(customDrinkSize.volume.value >= 0.0, "CustomDrinkSize did not initialize volume properly.")
        XCTAssert(customDrinkSize.alcoholRatio >= 0.0, "CustomDrinkSize did not initialize alcohol ratio properly.")
    }
    
    func test_alcoholMass() {
        let customDrinkSize = CustomDrinkSize(volume: testVolume, alcoholRatio: testAlcoholRatio)
        let expectedAlcoholMassGrams = 14.0178530719
        let difference = abs(customDrinkSize.alcoholMass.converted(to: UnitMass.grams).value - expectedAlcoholMassGrams)
        XCTAssert(difference < 0.05, "Alcohol mass was not calculated properly. Expected \(expectedAlcoholMassGrams), actual \(customDrinkSize.alcoholMass).")
    }
    
    func test_isEmpty_false() {
        let customDrinkSize = CustomDrinkSize(volume: testVolume, alcoholRatio: testAlcoholRatio)
        XCTAssertFalse(customDrinkSize.isEmpty)
    }
    
    func test_isEmpty_true() {
        let standardDrinkSize = CustomDrinkSize(volume: Measurement(value: -40.0, unit: UnitVolume.milliliters), alcoholRatio: 0.05)
        XCTAssertTrue(standardDrinkSize.isEmpty)
    }

}
