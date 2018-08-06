//
//  DrinkerInformationManager.swift
//  BACalculator
//
//  Created by James Ungaretti on 7/24/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import DrinkKit
import Foundation
import os.log

/// A persistent storage manager for `DrinkerInformation`.
class DrinkerInformationManager: DiskManager<DrinkerInformation> {
    
    /// The default `DrinkerInformationManager`. This `DrinkerInformationManager` saves information to `DrinkerInformation.json` in the Application Support directory.
    static var `default` = DrinkerInformationManager(fileURL: FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!.appendingPathComponent("DrinkerInformation").appendingPathExtension("json"))
    
    /// The `DrinkerInformation` managed by the `DrinkerInformationManager`, or a default `DrinkerInformation` if the information cannot be loaded from persistent storage.
    var drinkerInformation: DrinkerInformation {
        if managedData == nil {
            managedData = DrinkerInformation(weight: Measurement(value: 180.0, unit: UnitMass.pounds), sex: .male, alcoholMetabolism: .average)
            os_log("DrinkInformationManager initialized managedData.")
            saveToDisk()
        }
        return managedData!
    }
    
    /// Update the `DrinkerInformation` managed by the `DrinkerInformationManager`.
    ///
    /// - Parameter drinkerInformation: The new `DrinkerInformation`.
    func updateDrinkerInformation(_ drinkerInformation: DrinkerInformation) {
        managedData = drinkerInformation
        saveToDisk()
    }
    
    /// Update the `weight` property of the `DrinkerInformation` managed by the `DrinkerInformationManager`.
    ///
    /// - Parameter weight: The new `weight`.
    func updateDrinker(weight: Measurement<UnitMass>) {
        managedData?.weight = weight
        saveToDisk()
    }
    
    /// Update the `sex` property of the `DrinkerInformation` managed by the `DrinkerInformationManager`.
    ///
    /// - Parameter sex: The new `sex`.
    func updateDrinker(sex: DrinkerSex) {
        managedData?.sex = sex
        saveToDisk()
    }
    
    /// Update the `alcoholMetabolism` property of the `DrinkerInformation` managed by the `DrinkerInformationManager`.
    ///
    /// - Parameter alcoholMetabolism: The new `alcoholMetabolism`.
    func updateDrinker(alcoholMetabolism: DrinkerAlcoholMetabolism) {
        managedData?.alcoholMetabolism = alcoholMetabolism
        saveToDisk()
    }
    
}
