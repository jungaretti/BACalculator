//
//  BloodAlcoholCalculatorTests.swift
//  DrinkKitTests
//
//  Created by James Ungaretti on 7/24/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import XCTest
@testable import DrinkKit

class BloodAlcoholCalculatorTests: XCTestCase {
    
    var testDrinker: Drinker!
    
    override func setUp() {
        super.setUp()
        testDrinker = Drinker(weight: Measurement(value: 128.0, unit: UnitMass.pounds), sex: .male, alcoholMetabolism: .average)
    }
    
    override func tearDown() {
        testDrinker = nil
        super.tearDown()
    }
    
    func test_init() {
        let _ = BloodAlcoholCalculator(drinker: testDrinker)
    }
    
    func test_impact_standard() {
        let alcoholCalculator = BloodAlcoholCalculator(drinker: testDrinker)
        let drink = Drink(type: .beer, consumptionDate: Date(), size: StandardDrinkSize(standardDrinks: 1.0))
        let expectedImpact = 0.03350884039
        let difference = abs(alcoholCalculator.impact(of: drink) - expectedImpact)
        XCTAssert(difference < 0.005, "Drink impact was not calculated properly. Expected \(expectedImpact), actual \(alcoholCalculator.impact(of: drink)).")
    }
    
    func test_impact_custom() {
        let alcoholCalculator = BloodAlcoholCalculator(drinker: testDrinker)
        let drink = Drink(type: .liquor, consumptionDate: Date(), size: CustomDrinkSize(volume: Measurement(value: 3.0, unit: UnitVolume.fluidOunces), alcoholRatio: 0.40))
        let expectedImpact = 0.06710338995
        let difference = abs(alcoholCalculator.impact(of: drink) - expectedImpact)
        XCTAssert(difference < 0.005, "Drink impact was not calculated properly. Expected \(expectedImpact), actual \(alcoholCalculator.impact(of: drink)).")
    }
    
    func test_bloodAlcoholContent() {
        let alcoholCalculator = BloodAlcoholCalculator(drinker: testDrinker)
        // Setup [Drink]
        let referenceDate = Date()
        let measurementDate = referenceDate.addingTimeInterval(3600.0)
        var drinks = [Drink]()
        drinks.append(Drink(type: .beer, consumptionDate: referenceDate, size: StandardDrinkSize(standardDrinks: 1.0)))
        // Calculate difference
        let expectedBAC = 0.01650884039
        let difference = abs(alcoholCalculator.bloodAlcoholContent(atDate: measurementDate, afterDrinks: drinks) - expectedBAC)
        XCTAssert(difference < 0.0005, "BloodAlcoholCalculator did not calculate BAC properly. Expected \(expectedBAC), actual \(alcoholCalculator.bloodAlcoholContent(atDate: measurementDate, afterDrinks: drinks)).")
    }
    
    func test_bloodAlcoholContent_safeMode() {
        let alcoholCalculator = BloodAlcoholCalculator(drinker: testDrinker)
        // Setup [Drink]
        let referenceDate = Date()
        let measurementDate = referenceDate.addingTimeInterval(3600.0)
        var drinks = [Drink]()
        drinks.append(Drink(type: .beer, consumptionDate: referenceDate, size: StandardDrinkSize(standardDrinks: 1.0)))
        // Calculate difference
        let expectedBAC = 0.02150884039
        let difference = abs(alcoholCalculator.bloodAlcoholContent(atDate: measurementDate, afterDrinks: drinks, safeMode: true) - expectedBAC)
        XCTAssert(difference < 0.0005, "BloodAlcoholCalculator did not calculate BAC properly. Expected \(expectedBAC), actual \(alcoholCalculator.bloodAlcoholContent(atDate: measurementDate, afterDrinks: drinks)).")
    }
    
    func test_bloodAlcoholContent_threeHours() {
        let alcoholCalculator = BloodAlcoholCalculator(drinker: testDrinker)
        // Setup [Drink]
        let referenceDate = Date()
        let measurementDate = referenceDate.addingTimeInterval(10800)
        var drinks = [Drink]()
        drinks.append(Drink(type: .beer, consumptionDate: referenceDate, size: StandardDrinkSize(standardDrinks: 1.0)))
        // Calculate difference
        let expectedBAC = 0.0
        let difference = abs(alcoholCalculator.bloodAlcoholContent(atDate: measurementDate, afterDrinks: drinks) - expectedBAC)
        XCTAssert(difference < 0.0005, "BloodAlcoholCalculator did not calculate BAC properly. Expected \(expectedBAC), actual \(alcoholCalculator.bloodAlcoholContent(atDate: measurementDate, afterDrinks: drinks)).")
    }
    
    func test_bloodAlcoholContent_threeHoursSafeMode() {
        let alcoholCalculator = BloodAlcoholCalculator(drinker: testDrinker)
        // Setup [Drink]
        let referenceDate = Date()
        let measurementDate = referenceDate.addingTimeInterval(10800)
        var drinks = [Drink]()
        drinks.append(Drink(type: .beer, consumptionDate: referenceDate, size: StandardDrinkSize(standardDrinks: 1.0)))
        // Calculate difference
        let expectedBAC = 0.0
        let difference = abs(alcoholCalculator.bloodAlcoholContent(atDate: measurementDate, afterDrinks: drinks, safeMode: true) - expectedBAC)
        XCTAssert(difference < 0.0005, "BloodAlcoholCalculator did not calculate BAC properly. Expected \(expectedBAC), actual \(alcoholCalculator.bloodAlcoholContent(atDate: measurementDate, afterDrinks: drinks)).")
    }
    
    func test_bloodAlcoholContent_warp() {
        let alcoholCalculator = BloodAlcoholCalculator(drinker: testDrinker)
        // Setup [Drink]
        let referenceDate = Date()
        let measurementDate = referenceDate.addingTimeInterval(25200.0)
        var drinks = [Drink]()
        drinks.append(Drink(type: .beer, consumptionDate: referenceDate, size: StandardDrinkSize(standardDrinks: 1.0)))
        drinks.append(Drink(type: .beer, consumptionDate: referenceDate.addingTimeInterval(21600.0), size: StandardDrinkSize(standardDrinks: 1.0)))
        // Calculate difference
        let expectedBAC = 0.01650884039
        let difference = abs(alcoholCalculator.bloodAlcoholContent(atDate: measurementDate, afterDrinks: drinks) - expectedBAC)
        XCTAssert(difference < 0.0005, "BloodAlcoholCalculator did not calculate BAC properly. Expected \(expectedBAC), actual \(alcoholCalculator.bloodAlcoholContent(atDate: measurementDate, afterDrinks: drinks)).")
    }
    
    func test_bloodAlcoholContent_warpSafeMode() {
        let alcoholCalculator = BloodAlcoholCalculator(drinker: testDrinker)
        // Setup [Drink]
        let referenceDate = Date()
        let measurementDate = referenceDate.addingTimeInterval(25200.0)
        var drinks = [Drink]()
        drinks.append(Drink(type: .beer, consumptionDate: referenceDate, size: StandardDrinkSize(standardDrinks: 1.0)))
        drinks.append(Drink(type: .beer, consumptionDate: referenceDate.addingTimeInterval(21600.0), size: StandardDrinkSize(standardDrinks: 1.0)))
        // Calculate difference
        let expectedBAC = 0.02150884039
        let difference = abs(alcoholCalculator.bloodAlcoholContent(atDate: measurementDate, afterDrinks: drinks, safeMode: true) - expectedBAC)
        XCTAssert(difference < 0.0005, "BloodAlcoholCalculator did not calculate BAC properly. Expected \(expectedBAC), actual \(alcoholCalculator.bloodAlcoholContent(atDate: measurementDate, afterDrinks: drinks)).")
    }
    
    func test_bloodAlcoholContent_warpThreeHours() {
        let alcoholCalculator = BloodAlcoholCalculator(drinker: testDrinker)
        // Setup [Drink]
        let referenceDate = Date()
        let measurementDate = referenceDate.addingTimeInterval(32400.0)
        var drinks = [Drink]()
        drinks.append(Drink(type: .beer, consumptionDate: referenceDate, size: StandardDrinkSize(standardDrinks: 1.0)))
        drinks.append(Drink(type: .beer, consumptionDate: referenceDate.addingTimeInterval(21600.0), size: StandardDrinkSize(standardDrinks: 1.0)))
        // Calculate difference
        let expectedBAC = 0.0
        let difference = abs(alcoholCalculator.bloodAlcoholContent(atDate: measurementDate, afterDrinks: drinks) - expectedBAC)
        XCTAssert(difference < 0.0005, "BloodAlcoholCalculator did not calculate BAC properly. Expected \(expectedBAC), actual \(alcoholCalculator.bloodAlcoholContent(atDate: measurementDate, afterDrinks: drinks)).")
    }
    
    func test_bloodAlcoholContent_warpThreeHoursSafeMode() {
        let alcoholCalculator = BloodAlcoholCalculator(drinker: testDrinker)
        // Setup [Drink]
        let referenceDate = Date()
        let measurementDate = referenceDate.addingTimeInterval(32400.0)
        var drinks = [Drink]()
        drinks.append(Drink(type: .beer, consumptionDate: referenceDate, size: StandardDrinkSize(standardDrinks: 1.0)))
        drinks.append(Drink(type: .beer, consumptionDate: referenceDate.addingTimeInterval(21600.0), size: StandardDrinkSize(standardDrinks: 1.0)))
        // Calculate difference
        let expectedBAC = 0.0
        let difference = abs(alcoholCalculator.bloodAlcoholContent(atDate: measurementDate, afterDrinks: drinks, safeMode: true) - expectedBAC)
        XCTAssert(difference < 0.0005, "BloodAlcoholCalculator did not calculate BAC properly. Expected \(expectedBAC), actual \(alcoholCalculator.bloodAlcoholContent(atDate: measurementDate, afterDrinks: drinks)).")
    }
    
    func test_bloodAlcoholContent_many() {
        let alcoholCalculator = BloodAlcoholCalculator(drinker: testDrinker)
        // Setup [Drink]
        let referenceDate = Date()
        let measurementDate = referenceDate.addingTimeInterval(3600.0)
        var drinks = [Drink]()
        drinks.append(Drink(type: .beer, consumptionDate: referenceDate, size: StandardDrinkSize(standardDrinks: 1.0)))
        drinks.append(Drink(type: .liquor, consumptionDate: referenceDate, size: StandardDrinkSize(standardDrinks: 1.0)))
        drinks.append(Drink(type: .wine, consumptionDate: referenceDate, size: CustomDrinkSize(volume: Measurement(value: 1.5, unit: UnitVolume.fluidOunces), alcoholRatio: 0.40)))
        // Calculate difference
        let expectedBAC = 0.0835692523 // TODO: Fix
        let difference = abs(alcoholCalculator.bloodAlcoholContent(atDate: measurementDate, afterDrinks: drinks) - expectedBAC)
        XCTAssert(difference < 0.0005, "BloodAlcoholCalculator did not calculate BAC properly. Expected \(expectedBAC), actual \(alcoholCalculator.bloodAlcoholContent(atDate: measurementDate, afterDrinks: drinks)).")
    }
    
    func test_bloodAlcoholContent_warpMany() {
        let alcoholCalculator = BloodAlcoholCalculator(drinker: testDrinker)
        // Setup [Drink]
        let referenceDate = Date()
        let measurementDate = referenceDate.addingTimeInterval(25200)
        var drinks = [Drink]()
        drinks.append(Drink(type: .beer, consumptionDate: referenceDate, size: StandardDrinkSize(standardDrinks: 1.0)))
        drinks.append(Drink(type: .liquor, consumptionDate: referenceDate, size: StandardDrinkSize(standardDrinks: 1.0)))
        drinks.append(Drink(type: .wine, consumptionDate: referenceDate, size: CustomDrinkSize(volume: Measurement(value: 1.5, unit: UnitVolume.fluidOunces), alcoholRatio: 0.40)))
        drinks.append(Drink(type: .beer, consumptionDate: referenceDate.addingTimeInterval(21600.0), size: StandardDrinkSize(standardDrinks: 1.0)))
        drinks.append(Drink(type: .liquor, consumptionDate: referenceDate.addingTimeInterval(21600.0), size: StandardDrinkSize(standardDrinks: 1.0)))
        drinks.append(Drink(type: .wine, consumptionDate: referenceDate.addingTimeInterval(21600.0), size: CustomDrinkSize(volume: Measurement(value: 1.5, unit: UnitVolume.fluidOunces), alcoholRatio: 0.40)))
        // Calculate difference
        let expectedBAC = 0.0835692523 // TODO: Fix
        let difference = abs(alcoholCalculator.bloodAlcoholContent(atDate: measurementDate, afterDrinks: drinks) - expectedBAC)
        XCTAssert(difference < 0.0005, "BloodAlcoholCalculator did not calculate BAC properly. Expected \(expectedBAC), actual \(alcoholCalculator.bloodAlcoholContent(atDate: measurementDate, afterDrinks: drinks)).")
    }
    
    func test_bloodAlcoholContent_empty() {
        let alcoholCalculator = BloodAlcoholCalculator(drinker: testDrinker)
        // Setup [Drink]
        let referenceDate = Date()
        let measurementDate = referenceDate
        let drinks = [Drink]()
        // Calculate difference
        let expectedBAC = 0.0
        let difference = abs(alcoholCalculator.bloodAlcoholContent(atDate: measurementDate, afterDrinks: drinks) - expectedBAC)
        XCTAssert(difference < 0.0005, "BloodAlcoholCalculator did not calculate BAC properly. Expected \(expectedBAC), actual \(alcoholCalculator.bloodAlcoholContent(atDate: measurementDate, afterDrinks: drinks)).")
    }
    
    func test_bloodAlcoholContent_before() {
        let alcoholCalculator = BloodAlcoholCalculator(drinker: testDrinker)
        // Setup [Drink]
        let referenceDate = Date()
        let measurementDate = referenceDate.addingTimeInterval(-3600)
        var drinks = [Drink]()
        drinks.append(Drink(type: .beer, consumptionDate: referenceDate, size: StandardDrinkSize(standardDrinks: 1.0)))
        // Calculate difference
        let expectedBAC = 0.0
        let difference = abs(alcoholCalculator.bloodAlcoholContent(atDate: measurementDate, afterDrinks: drinks) - expectedBAC)
        XCTAssert(difference < 0.0005, "BloodAlcoholCalculator did not calculate BAC properly. Expected \(expectedBAC), actual \(alcoholCalculator.bloodAlcoholContent(atDate: measurementDate, afterDrinks: drinks)).")
    }
    
}
