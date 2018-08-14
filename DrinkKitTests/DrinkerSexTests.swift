//
//  DrinkerSexTests.swift
//  DrinkKitTests
//
//  Created by James Ungaretti on 8/14/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import XCTest
@testable import DrinkKit

class DrinkerSexTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_description_male() {
        let testSex = DrinkerSex.male
        let expectedDescription = "Male"
        XCTAssert(testSex.description == expectedDescription, "The DrinkerSex did not return the proper description. Expected \(expectedDescription), actual \(testSex.description).")
    }
    
    func test_description_female() {
        let testSex = DrinkerSex.female
        let expectedDescription = "Female"
        XCTAssert(testSex.description == expectedDescription, "The DrinkerSex did not return the proper description. Expected \(expectedDescription), actual \(testSex.description).")
    }
    
    func test_waterComposition_male() {
        let testSex = DrinkerSex.male
        let expectedWaterComposition = 0.58
        XCTAssert(testSex.waterComposition == expectedWaterComposition, "The DrinkerSex did not return the expcted waterComposition. Expected \(expectedWaterComposition), actual \(testSex.waterComposition).")
    }
    
    func test_waterComposition_female() {
        let testSex = DrinkerSex.female
        let expectedWaterComposition = 0.49
        XCTAssert(testSex.waterComposition == expectedWaterComposition, "The DrinkerSex did not return the expcted waterComposition. Expected \(expectedWaterComposition), actual \(testSex.waterComposition).")
    }
    
}
