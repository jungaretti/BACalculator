//
//  DrinkerInformationManager.swift
//  BACalculator
//
//  Created by James Ungaretti on 8/17/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import DrinkKit
import Foundation

/// A persistent data manager for the drinker information in BACalculator.
class DrinkerInformationManager: DiskManager<DrinkerInformation> {
    
    private var _drinkerInformation: DrinkerInformation?
    /// The `DrinkerInformation` managed by the `DrinkerInformationManager`.
    var drinkerInformation: DrinkerInformation? {
        return _drinkerInformation
    }
    
    /// The default `DrinkerInformationManager`.
    static var `default` = DrinkerInformationManager(fileURL: FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!.appendingPathComponent("DrinkerInformation").appendingPathExtension("json"))
    
    /// Update and replace the `DrinkerInformation`.
    ///
    /// - Parameter drinkerInformation: The new `DrinkerInformation`.
    func update(drinkerInformation: DrinkerInformation) {
        _drinkerInformation = drinkerInformation
        saveToDisk(_drinkerInformation!)
    }
    
    /// Update the `weight` of the `drinkerInformation`. If `drinkerInformation` is `nil`, this method will do nothing.
    ///
    /// - Parameter weight: The new `weight`.
    func update(weight: Measurement<UnitMass>) {
        if _drinkerInformation != nil {
            _drinkerInformation!.weight = weight
            update(drinkerInformation: _drinkerInformation!)
        }
    }
    
    /// Update the `sex` of the `drinkerInformation`. If `drinkerInformation` is `nil`, this method will do nothing.
    ///
    /// - Parameter sex: The new `sex`.
    func update(sex: DrinkerSex) {
        if _drinkerInformation != nil {
            _drinkerInformation!.sex = sex
            update(drinkerInformation: _drinkerInformation!)
        }
    }
    
    /// Update the `alcoholMetabolism` of the `drinkerInformation`. If `drinkerInformation` is `nil`, this method will do nothing.
    ///
    /// - Parameter alcoholMetabolism: The new `alcoholMetabolism`.
    func update(alcoholMetabolism: DrinkerAlcoholMetabolism) {
        if _drinkerInformation != nil {
            _drinkerInformation!.alcoholMetabolism = alcoholMetabolism
            update(drinkerInformation: _drinkerInformation!)
        }
    }
    
}
