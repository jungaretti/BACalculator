//
//  DrinkerInformationTests.swift
//  DrinkKitTests
//
//  Created by James Ungaretti on 7/24/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import XCTest
@testable import DrinkKit

class DrinkerInformationTests: XCTestCase {
    
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
        let drinkerInformation = DrinkerInformation(weight: testWeight, sex: testSex, alcoholMetabolism: testAlcoholMetabolism)
        XCTAssert(drinkerInformation.weight == testWeight, "DrinkerInformation did not properly initialize weight.")
        XCTAssert(drinkerInformation.sex == testSex, "DrinkerInformation did not properly initialize sex.")
        XCTAssert(drinkerInformation.alcoholMetabolism == testAlcoholMetabolism, "DrinkerInformation did not properly initialize alcohol metabolism.")
    }
    
    func test_waterVolume() {
        let drinkerInformation = DrinkerInformation(weight: testWeight, sex: testSex, alcoholMetabolism: testAlcoholMetabolism)
        let expectedWaterVolume = Measurement(value: 33674.6974332722, unit: UnitVolume.milliliters)
        let difference = abs((drinkerInformation.waterVolume - expectedWaterVolume).converted(to: UnitVolume.milliliters).value)
        XCTAssert(difference < 0.05, "Water volume was not calculated properly. Expected \(expectedWaterVolume), actual \(drinkerInformation.waterVolume).")
    }
    
}
