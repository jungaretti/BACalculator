//
//  AlcoholCalculatorTests.swift
//  DrinkKitTests
//
//  Created by James Ungaretti on 7/24/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import XCTest
@testable import DrinkKit

class AlcoholCalculatorTests: XCTestCase {
    
    var testDrinkerInformation: DrinkerInformation!
    
    override func setUp() {
        super.setUp()
        testDrinkerInformation = DrinkerInformation(weight: Measurement(value: 128.0, unit: UnitMass.pounds), sex: .male, alcoholMetabolism: .average)
    }
    
    override func tearDown() {
        testDrinkerInformation = nil
        super.tearDown()
    }
    
    func test_init() {
        let alcoholCalculator = AlcoholCalculator(drinkerInformation: testDrinkerInformation)
        XCTAssert(alcoholCalculator.safeMode == nil, "AlcoholCalculator assigned a value to safeMode, even though no value was specified.")
    }
    
    func test_init_safeMode() {
        let alcoholCalculator = AlcoholCalculator(drinkerInformation: testDrinkerInformation, safeMode: true)
        XCTAssert(alcoholCalculator.safeMode == true, "AlcoholCalculator did not assign the proper value to safeMode.")
    }
    
    func test_impact_standard() {
        let alcoholCalculator = AlcoholCalculator(drinkerInformation: testDrinkerInformation)
        let drink = Drink(type: .beer, consumptionDate: Date(), size: StandardDrinkSize(standardDrinks: 1.0))
        let expectedImpact = 0.03350884039
        let difference = abs(alcoholCalculator.impact(of: drink) - expectedImpact)
        XCTAssert(difference < 0.005, "Drink impact was not calculated properly. Expected \(expectedImpact), actual \(alcoholCalculator.impact(of: drink)).")
    }
    
    func test_impact_custom() {
        let alcoholCalculator = AlcoholCalculator(drinkerInformation: testDrinkerInformation)
        let drink = Drink(type: .liquor, consumptionDate: Date(), size: CustomDrinkSize(volume: Measurement(value: 3.0, unit: UnitVolume.fluidOunces), alcoholRatio: 0.40))
        let expectedImpact = 0.06710338995
        let difference = abs(alcoholCalculator.impact(of: drink) - expectedImpact)
        XCTAssert(difference < 0.005, "Drink impact was not calculated properly. Expected \(expectedImpact), actual \(alcoholCalculator.impact(of: drink)).")
    }
    
    func test_metabolized() {
        let alcoholCalculator = AlcoholCalculator(drinkerInformation: testDrinkerInformation)
        let timeInterval = 5400.0
        let expectedAlcoholMetabolized = 0.0255
        let difference = abs(alcoholCalculator.alcoholMetabolized(over: timeInterval) - expectedAlcoholMetabolized)
        XCTAssert(difference < 0.005, "Alcohol metabolized was not calculated properly. Expected \(expectedAlcoholMetabolized), actual \(alcoholCalculator.alcoholMetabolized(over: timeInterval)).")
    }
    
    func test_metabolized_safeMode() {
        let alcoholCalculator = AlcoholCalculator(drinkerInformation: testDrinkerInformation, safeMode: true)
        let timeInterval = 7200.0
        let expectedAlcoholMetabolized = 0.024
        let difference = abs(alcoholCalculator.alcoholMetabolized(over: timeInterval) - expectedAlcoholMetabolized)
        XCTAssert(difference < 0.005, "Alcohol metabolized was not calculated properly. Expected \(expectedAlcoholMetabolized), actual \(alcoholCalculator.alcoholMetabolized(over: timeInterval)).")
    }
    
    func test_bloodAlcoholContent() {
        let alcoholCalculator = AlcoholCalculator(drinkerInformation: testDrinkerInformation)
        // Setup [Drink]
        let referenceDate = Date()
        let measurementDate = referenceDate.addingTimeInterval(3600.0)
        var drinks = [Drink]()
        drinks.append(Drink(type: .beer, consumptionDate: referenceDate, size: StandardDrinkSize(standardDrinks: 1.0)))
        // Calculate difference
        let expectedBAC = 0.01650884039
        let difference = abs(alcoholCalculator.bloodAlcoholContent(atDate: measurementDate, afterDrinks: drinks) - expectedBAC)
        XCTAssert(difference < 0.0005, "AlcoholCalculator did not calculate BAC properly. Expected \(expectedBAC), actual \(alcoholCalculator.bloodAlcoholContent(atDate: measurementDate, afterDrinks: drinks)).")
    }
    
    func test_bloodAlcoholContent_safeMode() {
        let alcoholCalculator = AlcoholCalculator(drinkerInformation: testDrinkerInformation, safeMode: true)
        // Setup [Drink]
        let referenceDate = Date()
        let measurementDate = referenceDate.addingTimeInterval(3600.0)
        var drinks = [Drink]()
        drinks.append(Drink(type: .beer, consumptionDate: referenceDate, size: StandardDrinkSize(standardDrinks: 1.0)))
        // Calculate difference
        let expectedBAC = 0.02150884039
        let difference = abs(alcoholCalculator.bloodAlcoholContent(atDate: measurementDate, afterDrinks: drinks) - expectedBAC)
        XCTAssert(difference < 0.0005, "AlcoholCalculator did not calculate BAC properly. Expected \(expectedBAC), actual \(alcoholCalculator.bloodAlcoholContent(atDate: measurementDate, afterDrinks: drinks)).")
    }
    
    func test_bloodAlcoholContent_threeHours() {
        let alcoholCalculator = AlcoholCalculator(drinkerInformation: testDrinkerInformation)
        // Setup [Drink]
        let referenceDate = Date()
        let measurementDate = referenceDate.addingTimeInterval(10800)
        var drinks = [Drink]()
        drinks.append(Drink(type: .beer, consumptionDate: referenceDate, size: StandardDrinkSize(standardDrinks: 1.0)))
        // Calculate difference
        let expectedBAC = 0.0
        let difference = abs(alcoholCalculator.bloodAlcoholContent(atDate: measurementDate, afterDrinks: drinks) - expectedBAC)
        XCTAssert(difference < 0.0005, "AlcoholCalculator did not calculate BAC properly. Expected \(expectedBAC), actual \(alcoholCalculator.bloodAlcoholContent(atDate: measurementDate, afterDrinks: drinks)).")
    }
    
    func test_bloodAlcoholContent_threeHoursSafeMode() {
        let alcoholCalculator = AlcoholCalculator(drinkerInformation: testDrinkerInformation, safeMode: true)
        // Setup [Drink]
        let referenceDate = Date()
        let measurementDate = referenceDate.addingTimeInterval(10800)
        var drinks = [Drink]()
        drinks.append(Drink(type: .beer, consumptionDate: referenceDate, size: StandardDrinkSize(standardDrinks: 1.0)))
        // Calculate difference
        let expectedBAC = 0.0
        let difference = abs(alcoholCalculator.bloodAlcoholContent(atDate: measurementDate, afterDrinks: drinks) - expectedBAC)
        XCTAssert(difference < 0.0005, "AlcoholCalculator did not calculate BAC properly. Expected \(expectedBAC), actual \(alcoholCalculator.bloodAlcoholContent(atDate: measurementDate, afterDrinks: drinks)).")
    }
    
    func test_bloodAlcoholContent_warp() {
        let alcoholCalculator = AlcoholCalculator(drinkerInformation: testDrinkerInformation)
        // Setup [Drink]
        let referenceDate = Date()
        let measurementDate = referenceDate.addingTimeInterval(25200.0)
        var drinks = [Drink]()
        drinks.append(Drink(type: .beer, consumptionDate: referenceDate, size: StandardDrinkSize(standardDrinks: 1.0)))
        drinks.append(Drink(type: .beer, consumptionDate: referenceDate.addingTimeInterval(21600.0), size: StandardDrinkSize(standardDrinks: 1.0)))
        // Calculate difference
        let expectedBAC = 0.01650884039
        let difference = abs(alcoholCalculator.bloodAlcoholContent(atDate: measurementDate, afterDrinks: drinks) - expectedBAC)
        XCTAssert(difference < 0.0005, "AlcoholCalculator did not calculate BAC properly. Expected \(expectedBAC), actual \(alcoholCalculator.bloodAlcoholContent(atDate: measurementDate, afterDrinks: drinks)).")
    }
    
    func test_bloodAlcoholContent_warpSafeMode() {
        let alcoholCalculator = AlcoholCalculator(drinkerInformation: testDrinkerInformation, safeMode: true)
        // Setup [Drink]
        let referenceDate = Date()
        let measurementDate = referenceDate.addingTimeInterval(25200.0)
        var drinks = [Drink]()
        drinks.append(Drink(type: .beer, consumptionDate: referenceDate, size: StandardDrinkSize(standardDrinks: 1.0)))
        drinks.append(Drink(type: .beer, consumptionDate: referenceDate.addingTimeInterval(21600.0), size: StandardDrinkSize(standardDrinks: 1.0)))
        // Calculate difference
        let expectedBAC = 0.02150884039
        let difference = abs(alcoholCalculator.bloodAlcoholContent(atDate: measurementDate, afterDrinks: drinks) - expectedBAC)
        XCTAssert(difference < 0.0005, "AlcoholCalculator did not calculate BAC properly. Expected \(expectedBAC), actual \(alcoholCalculator.bloodAlcoholContent(atDate: measurementDate, afterDrinks: drinks)).")
    }
    
    func test_bloodAlcoholContent_warpThreeHours() {
        let alcoholCalculator = AlcoholCalculator(drinkerInformation: testDrinkerInformation)
        // Setup [Drink]
        let referenceDate = Date()
        let measurementDate = referenceDate.addingTimeInterval(32400.0)
        var drinks = [Drink]()
        drinks.append(Drink(type: .beer, consumptionDate: referenceDate, size: StandardDrinkSize(standardDrinks: 1.0)))
        drinks.append(Drink(type: .beer, consumptionDate: referenceDate.addingTimeInterval(21600.0), size: StandardDrinkSize(standardDrinks: 1.0)))
        // Calculate difference
        let expectedBAC = 0.0
        let difference = abs(alcoholCalculator.bloodAlcoholContent(atDate: measurementDate, afterDrinks: drinks) - expectedBAC)
        XCTAssert(difference < 0.0005, "AlcoholCalculator did not calculate BAC properly. Expected \(expectedBAC), actual \(alcoholCalculator.bloodAlcoholContent(atDate: measurementDate, afterDrinks: drinks)).")
    }
    
    func test_bloodAlcoholContent_warpThreeHoursSafeMode() {
        let alcoholCalculator = AlcoholCalculator(drinkerInformation: testDrinkerInformation, safeMode: true)
        // Setup [Drink]
        let referenceDate = Date()
        let measurementDate = referenceDate.addingTimeInterval(32400.0)
        var drinks = [Drink]()
        drinks.append(Drink(type: .beer, consumptionDate: referenceDate, size: StandardDrinkSize(standardDrinks: 1.0)))
        drinks.append(Drink(type: .beer, consumptionDate: referenceDate.addingTimeInterval(21600.0), size: StandardDrinkSize(standardDrinks: 1.0)))
        // Calculate difference
        let expectedBAC = 0.0
        let difference = abs(alcoholCalculator.bloodAlcoholContent(atDate: measurementDate, afterDrinks: drinks) - expectedBAC)
        XCTAssert(difference < 0.0005, "AlcoholCalculator did not calculate BAC properly. Expected \(expectedBAC), actual \(alcoholCalculator.bloodAlcoholContent(atDate: measurementDate, afterDrinks: drinks)).")
    }
    
    func test_bloodAlcoholContent_many() {
        let alcoholCalculator = AlcoholCalculator(drinkerInformation: testDrinkerInformation)
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
        XCTAssert(difference < 0.0005, "AlcoholCalculator did not calculate BAC properly. Expected \(expectedBAC), actual \(alcoholCalculator.bloodAlcoholContent(atDate: measurementDate, afterDrinks: drinks)).")
    }
    
    func test_bloodAlcoholContent_warpMany() {
        let alcoholCalculator = AlcoholCalculator(drinkerInformation: testDrinkerInformation)
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
        XCTAssert(difference < 0.0005, "AlcoholCalculator did not calculate BAC properly. Expected \(expectedBAC), actual \(alcoholCalculator.bloodAlcoholContent(atDate: measurementDate, afterDrinks: drinks)).")
    }
    
    func test_bloodAlcoholContent_empty() {
        let alcoholCalculator = AlcoholCalculator(drinkerInformation: testDrinkerInformation)
        // Setup [Drink]
        let referenceDate = Date()
        let measurementDate = referenceDate
        let drinks = [Drink]()
        // Calculate difference
        let expectedBAC = 0.0
        let difference = abs(alcoholCalculator.bloodAlcoholContent(atDate: measurementDate, afterDrinks: drinks) - expectedBAC)
        XCTAssert(difference < 0.0005, "AlcoholCalculator did not calculate BAC properly. Expected \(expectedBAC), actual \(alcoholCalculator.bloodAlcoholContent(atDate: measurementDate, afterDrinks: drinks)).")
    }
    
    func test_bloodAlcoholContent_before() {
        let alcoholCalculator = AlcoholCalculator(drinkerInformation: testDrinkerInformation)
        // Setup [Drink]
        let referenceDate = Date()
        let measurementDate = referenceDate.addingTimeInterval(-3600)
        var drinks = [Drink]()
        drinks.append(Drink(type: .beer, consumptionDate: referenceDate, size: StandardDrinkSize(standardDrinks: 1.0)))
        // Calculate difference
        let expectedBAC = 0.0
        let difference = abs(alcoholCalculator.bloodAlcoholContent(atDate: measurementDate, afterDrinks: drinks) - expectedBAC)
        XCTAssert(difference < 0.0005, "AlcoholCalculator did not calculate BAC properly. Expected \(expectedBAC), actual \(alcoholCalculator.bloodAlcoholContent(atDate: measurementDate, afterDrinks: drinks)).")
    }
    
    func testPerformance_bloodAlcoholContent_single() {
        let alcoholCalculator = AlcoholCalculator(drinkerInformation: testDrinkerInformation)
        // Setup [Drink]
        let referenceDate = Date()
        let measurementDate = referenceDate.addingTimeInterval(3600.0)
        var drinks = [Drink]()
        for i in 0 ..< 1 {
            drinks.append(Drink(type: .beer, consumptionDate: referenceDate.addingTimeInterval(TimeInterval(i * 1800)), size: StandardDrinkSize(standardDrinks: 1.0)))
        }
        // Measure calculation time
        self.measure {
            _ = alcoholCalculator.bloodAlcoholContent(atDate: measurementDate, afterDrinks: drinks)
        }
    }
    
    func testPerformance_bloodAlcoholContent_100() {
        let alcoholCalculator = AlcoholCalculator(drinkerInformation: testDrinkerInformation)
        // Setup [Drink]
        let referenceDate = Date()
        let measurementDate = referenceDate.addingTimeInterval(3600.0)
        var drinks = [Drink]()
        for i in 0 ..< 100 {
            drinks.append(Drink(type: .beer, consumptionDate: referenceDate.addingTimeInterval(TimeInterval(i * 1800)), size: StandardDrinkSize(standardDrinks: 1.0)))
        }
        // Measure calculation time
        self.measure {
            _ = alcoholCalculator.bloodAlcoholContent(atDate: measurementDate, afterDrinks: drinks)
        }
    }
    
    func testPerformance_bloodAlcoholContent_1000() {
        let alcoholCalculator = AlcoholCalculator(drinkerInformation: testDrinkerInformation)
        // Setup [Drink]
        let referenceDate = Date()
        let measurementDate = referenceDate.addingTimeInterval(3600.0)
        var drinks = [Drink]()
        for i in 0 ..< 1000 {
            drinks.append(Drink(type: .beer, consumptionDate: referenceDate.addingTimeInterval(TimeInterval(i * 1800)), size: StandardDrinkSize(standardDrinks: 1.0)))
        }
        // Measure calculation time
        self.measure {
            _ = alcoholCalculator.bloodAlcoholContent(atDate: measurementDate, afterDrinks: drinks)
        }
    }
    
    func testPerformance_bloodAlcoholContent_10000() {
        let alcoholCalculator = AlcoholCalculator(drinkerInformation: testDrinkerInformation)
        // Setup [Drink]
        let referenceDate = Date()
        let measurementDate = referenceDate.addingTimeInterval(3600.0)
        var drinks = [Drink]()
        for i in 0 ..< 10000 {
            drinks.append(Drink(type: .beer, consumptionDate: referenceDate.addingTimeInterval(TimeInterval(i * 1800)), size: StandardDrinkSize(standardDrinks: 1.0)))
        }
        // Measure calculation time
        self.measure {
            _ = alcoholCalculator.bloodAlcoholContent(atDate: measurementDate, afterDrinks: drinks)
        }
    }
    
    func testPerformance_bloodAlcoholContent_100000() {
        let alcoholCalculator = AlcoholCalculator(drinkerInformation: testDrinkerInformation)
        // Setup [Drink]
        let referenceDate = Date()
        let measurementDate = referenceDate.addingTimeInterval(3600.0)
        var drinks = [Drink]()
        for i in 0 ..< 100000 {
            drinks.append(Drink(type: .beer, consumptionDate: referenceDate.addingTimeInterval(TimeInterval(i * 1800)), size: StandardDrinkSize(standardDrinks: 1.0)))
        }
        // Measure calculation time
        self.measure {
            _ = alcoholCalculator.bloodAlcoholContent(atDate: measurementDate, afterDrinks: drinks)
        }
    }
    
    func testPerformance_bloodAlcoholContent_1000000() {
        let alcoholCalculator = AlcoholCalculator(drinkerInformation: testDrinkerInformation)
        // Setup [Drink]
        let referenceDate = Date()
        let measurementDate = referenceDate.addingTimeInterval(3600.0)
        var drinks = [Drink]()
        for i in 0 ..< 1000000 {
            drinks.append(Drink(type: .beer, consumptionDate: referenceDate.addingTimeInterval(TimeInterval(i * 1800)), size: StandardDrinkSize(standardDrinks: 1.0)))
        }
        // Measure calculation time
        self.measure {
            _ = alcoholCalculator.bloodAlcoholContent(atDate: measurementDate, afterDrinks: drinks)
        }
    }
    
}
