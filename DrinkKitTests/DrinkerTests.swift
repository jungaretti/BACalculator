//
//  DrinkerTests.swift
//  DrinkKitTests
//
//  Created by James Ungaretti on 7/24/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import XCTest
@testable import DrinkKit

class DrinkerTests: XCTestCase {
    
    var testWeight: Measurement<UnitMass>!
    var testSex: DrinkerSex!
    var testAlcoholMetabolism: DrinkerAlcoholMetabolism!
    
    override func setUp() {
        super.setUp()
        testWeight = Measurement(value: 128, unit: UnitMass.pounds)
        testSex = DrinkerSex.male
        testAlcoholMetabolism = DrinkerAlcoholMetabolism.average
    }
    
    override func tearDown() {
        testWeight = nil
        testSex = nil
        testAlcoholMetabolism = nil
        super.tearDown()
    }
    
    func test_init() {
        let drinker = Drinker(weight: testWeight, sex: testSex, alcoholMetabolism: testAlcoholMetabolism)
        XCTAssert(drinker.weight == testWeight, "Drinker did not properly initialize weight.")
        XCTAssert(drinker.sex == testSex, "Drinker did not properly initialize sex.")
        XCTAssert(drinker.alcoholMetabolism == testAlcoholMetabolism, "Drinker did not properly initialize alcohol metabolism.")
    }
    
    func test_waterVolume() {
        let drinker = Drinker(weight: testWeight, sex: testSex, alcoholMetabolism: testAlcoholMetabolism)
        let expectedWaterVolume = Measurement(value: 33674.6974332722, unit: UnitVolume.milliliters)
        let difference = abs((drinker.waterVolume - expectedWaterVolume).converted(to: UnitVolume.milliliters).value)
        XCTAssert(difference < 0.05, "Water volume was not calculated properly. Expected \(expectedWaterVolume), actual \(drinker.waterVolume).")
    }
    
}
