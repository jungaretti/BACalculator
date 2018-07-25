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
    
    func test_waterComposition_male() {
        let drinkerInformation = DrinkerInformation(weight: testWeight, sex: .male, alcoholMetabolism: testAlcoholMetabolism)
        let expectedWaterComposition = 0.58
        XCTAssert(drinkerInformation.sex.waterComposition == expectedWaterComposition, "DrinkerSex.male did not return the expcted waterComposition. Expected \(expectedWaterComposition), actual \(drinkerInformation.sex.waterComposition).")
    }
    
    func test_waterComposition_female() {
        let drinkerInformation = DrinkerInformation(weight: testWeight, sex: .female, alcoholMetabolism: testAlcoholMetabolism)
        let expectedWaterComposition = 0.49
        XCTAssert(drinkerInformation.sex.waterComposition == expectedWaterComposition, "DrinkerSex.female did not return the expcted waterComposition. Expected \(expectedWaterComposition), actual \(drinkerInformation.sex.waterComposition).")
    }
    
    func test_hourlyAlcoholMetabolism_belowAverage() {
        let drinkerInformation = DrinkerInformation(weight: testWeight, sex: testSex, alcoholMetabolism: .belowAverage)
        let expectedHourlyAlcoholMetabolism = 0.012
        XCTAssert(drinkerInformation.alcoholMetabolism.hourlyAlcoholMetabolism == expectedHourlyAlcoholMetabolism, "DrinkerAlcoholMetabolism.belowAverage did not return the expected hourlyAlcoholMetabolism. Expected \(expectedHourlyAlcoholMetabolism), actual \(drinkerInformation.alcoholMetabolism.hourlyAlcoholMetabolism).")
    }
    
    func test_hourlyAlcoholMetabolism_average() {
        let drinkerInformation = DrinkerInformation(weight: testWeight, sex: testSex, alcoholMetabolism: .average)
        let expectedHourlyAlcoholMetabolism = 0.017
        XCTAssert(drinkerInformation.alcoholMetabolism.hourlyAlcoholMetabolism == expectedHourlyAlcoholMetabolism, "DrinkerAlcoholMetabolism.average did not return the expected hourlyAlcoholMetabolism. Expected \(expectedHourlyAlcoholMetabolism), actual \(drinkerInformation.alcoholMetabolism.hourlyAlcoholMetabolism).")
    }
    
    func test_hourlyAlcoholMetabolism_aboveAverage() {
        let drinkerInformation = DrinkerInformation(weight: testWeight, sex: testSex, alcoholMetabolism: .aboveAverage)
        let expectedHourlyAlcoholMetabolism = 0.02
        XCTAssert(drinkerInformation.alcoholMetabolism.hourlyAlcoholMetabolism == expectedHourlyAlcoholMetabolism, "DrinkerAlcoholMetabolism.aboveAverage did not return the expected hourlyAlcoholMetabolism. Expected \(expectedHourlyAlcoholMetabolism), actual \(drinkerInformation.alcoholMetabolism.hourlyAlcoholMetabolism).")
    }
    
}
