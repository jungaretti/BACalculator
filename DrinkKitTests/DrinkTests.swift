//
//  DrinkTests.swift
//  DrinkKitTests
//
//  Created by James Ungaretti on 7/24/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import XCTest
@testable import DrinkKit

class DrinkTests: XCTestCase {
    
    var testType: DrinkType!
    var testConsumptionDate: Date!
    var testSize: DrinkSize!
    
    override func setUp() {
        super.setUp()
        testType = .liquor
        testConsumptionDate = Date(timeIntervalSince1970: 1524209520.0)
        testSize = StandardDrinkSize(standardDrinks: 1.0)
    }
    
    override func tearDown() {
        testType = nil
        testConsumptionDate = nil
        testSize = nil
        super.tearDown()
    }
    
    func test_init() {
        let drink = Drink(type: testType, consumptionDate: testConsumptionDate, size: testSize)
        XCTAssert(drink.type == testType, "Drink did not properly initialize type.")
        XCTAssert(drink.consumptionDate == testConsumptionDate, "Drink did not properly initialize consumption date.")
        XCTAssert(drink.size.alcoholMass == testSize.alcoholMass, "Drink did not properly initialize size. Expected alcohol mass \(testSize.alcoholMass), actual alcohol mass \(drink.size.alcoholMass).")
        XCTAssertTrue(drink.size is StandardDrinkSize, "Drink did not properly initialize size. A StandardDrinkSize was not stored.")
    }
    
    func test_encodeDecodeStandard() {
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        let testStandardDrinks = 1.0
        let testDrink = Drink(type: testType, consumptionDate: testConsumptionDate, size: StandardDrinkSize(standardDrinks: testStandardDrinks))
        let testDrinkData = try! encoder.encode(testDrink)
        let decodedDrink = try! decoder.decode(Drink.self, from: testDrinkData)
        XCTAssert(testDrink.type == decodedDrink.type)
        XCTAssert(testDrink.consumptionDate == decodedDrink.consumptionDate)
        if let decodedStandardSize = decodedDrink.size as? StandardDrinkSize {
            XCTAssert(decodedStandardSize.standardDrinks == testStandardDrinks)
        } else {
            XCTFail("The decoded drink does not hold a StandardDrinkSize.")
        }
    }
    
    func test_encodedDecodeCustom() {
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        let testVolume = Measurement(value: 1.5, unit: UnitVolume.fluidOunces)
        let testAlcoholRatio = 0.40
        let testDrink = Drink(type: testType, consumptionDate: testConsumptionDate, size: CustomDrinkSize(volume: testVolume, alcoholRatio: testAlcoholRatio))
        let testDrinkData = try! encoder.encode(testDrink)
        let decodedDrink = try! decoder.decode(Drink.self, from: testDrinkData)
        XCTAssert(testDrink.type == decodedDrink.type)
        XCTAssert(testDrink.consumptionDate == decodedDrink.consumptionDate)
        if let decodedCustomSize = decodedDrink.size as? CustomDrinkSize {
            let volumeDifference = abs((testVolume - decodedCustomSize.volume).converted(to: UnitVolume.milliliters).value)
            XCTAssertLessThan(volumeDifference, 0.001)
            let alcoholRatioDifference = abs(testAlcoholRatio - decodedCustomSize.alcoholRatio)
            XCTAssertLessThan(alcoholRatioDifference, 0.001)
        } else {
            XCTFail("The decoded drink does not hold a CustomDrinkSize.")
        }
    }
    
    func test_comparison_lessThan_standard() {
        let lhs = Drink(type: testType, consumptionDate: testConsumptionDate, size: StandardDrinkSize(standardDrinks: 1.0))
        let rhs = Drink(type: testType, consumptionDate: testConsumptionDate, size: StandardDrinkSize(standardDrinks: 2.0))
        XCTAssertTrue(lhs < rhs, "Two `StandardDrinkSize`s did not compare properly.")
    }
    
    func test_comparison_lessThan_custom() {
        let lhs = Drink(type: testType, consumptionDate: testConsumptionDate, size: CustomDrinkSize(volume: Measurement(value: 1.5, unit: UnitVolume.fluidOunces), alcoholRatio: 0.40))
        let rhs = Drink(type: testType, consumptionDate: testConsumptionDate, size: CustomDrinkSize(volume: Measurement(value: 3.0, unit: UnitVolume.fluidOunces), alcoholRatio: 0.40))
        XCTAssertTrue(lhs < rhs, "Two `CustomDrinkSize`s did not compare properly.")
    }
    
    func test_comparison_lessThan_mixed() {
        let lhs = Drink(type: testType, consumptionDate: testConsumptionDate, size: StandardDrinkSize(standardDrinks: 1.0))
        let rhs = Drink(type: testType, consumptionDate: testConsumptionDate, size: CustomDrinkSize(volume: Measurement(value: 3.0, unit: UnitVolume.fluidOunces), alcoholRatio: 0.40))
        XCTAssertTrue(lhs < rhs, "One `StandardDrinkSize` and one `CustomDrinkSize` did not compare properly.")
    }
    
    func test_comparison_greaterThan_standard() {
        let lhs = Drink(type: testType, consumptionDate: testConsumptionDate, size: StandardDrinkSize(standardDrinks: 1.0))
        let rhs = Drink(type: testType, consumptionDate: testConsumptionDate, size: StandardDrinkSize(standardDrinks: 2.0))
        XCTAssertFalse(lhs > rhs, "Two `StandardDrinkSize`s did not compare properly.")
    }
    
    func test_comparison_greaterThan_custom() {
        let lhs = Drink(type: testType, consumptionDate: testConsumptionDate, size: CustomDrinkSize(volume: Measurement(value: 1.5, unit: UnitVolume.fluidOunces), alcoholRatio: 0.40))
        let rhs = Drink(type: testType, consumptionDate: testConsumptionDate, size: CustomDrinkSize(volume: Measurement(value: 3.0, unit: UnitVolume.fluidOunces), alcoholRatio: 0.40))
        XCTAssertFalse(lhs > rhs, "Two `CustomDrinkSize`s did not compare properly.")
    }
    
    func test_comparison_greaterThan_mixed() {
        let lhs = Drink(type: testType, consumptionDate: testConsumptionDate, size: StandardDrinkSize(standardDrinks: 1.0))
        let rhs = Drink(type: testType, consumptionDate: testConsumptionDate, size: CustomDrinkSize(volume: Measurement(value: 3.0, unit: UnitVolume.fluidOunces), alcoholRatio: 0.40))
        XCTAssertFalse(lhs > rhs, "One `StandardDrinkSize` and one `CustomDrinkSize` did not compare properly.")
    }
    
    func test_equatable_standard() {
        let lhs = Drink(type: testType, consumptionDate: testConsumptionDate, size: StandardDrinkSize(standardDrinks: 1.0))
        let rhs = Drink(type: testType, consumptionDate: testConsumptionDate, size: StandardDrinkSize(standardDrinks: 1.0))
        XCTAssertTrue(lhs == rhs, "Two `StandardDrinkSize`s did not equate properly.")
    }
    
    func test_equatable_custom() {
        let lhs = Drink(type: testType, consumptionDate: testConsumptionDate, size: CustomDrinkSize(volume: Measurement(value: 1.5, unit: UnitVolume.fluidOunces), alcoholRatio: 0.40))
        let rhs = Drink(type: testType, consumptionDate: testConsumptionDate, size: CustomDrinkSize(volume: Measurement(value: 1.5, unit: UnitVolume.fluidOunces), alcoholRatio: 0.40))
        XCTAssertTrue(lhs == rhs, "Two `CustomDrinkSize`s did not equate properly.")
    }
    
    func test_drinkSort() {
        var drinks = [Drink]()
        drinks.append(Drink(type: testType, consumptionDate: testConsumptionDate, size: StandardDrinkSize(standardDrinks: 1.0)))
        drinks.append(Drink(type: testType, consumptionDate: testConsumptionDate.addingTimeInterval(-3600.0), size: StandardDrinkSize(standardDrinks: 1.0)))
        drinks.append(Drink(type: testType, consumptionDate: testConsumptionDate.addingTimeInterval(60.0), size: StandardDrinkSize(standardDrinks: 1.0)))
        drinks.append(Drink(type: testType, consumptionDate: testConsumptionDate.addingTimeInterval(-1800.0), size: StandardDrinkSize(standardDrinks: 1.0)))
        drinks.append(Drink(type: testType, consumptionDate: testConsumptionDate.addingTimeInterval(7200.0), size: StandardDrinkSize(standardDrinks: 1.0)))
        // Use non-mutating sort
        let drinksSortedByDate = drinks.sortedByDate()
        for i in 1 ..< drinks.count {
            if drinksSortedByDate[i].consumptionDate < drinksSortedByDate[i - 1].consumptionDate { XCTFail("A [Drink] was not sorted properly.") }
        }
        // Use mutating sort
        drinks.sortByDate()
        for i in 1 ..< drinks.count {
            if drinks[i].consumptionDate < drinks[i - 1].consumptionDate { XCTFail("A [Drink] was not sorted properly.") }
        }
    }
    
}
