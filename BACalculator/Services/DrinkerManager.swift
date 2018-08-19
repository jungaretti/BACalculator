//
//  DrinkerManager.swift
//  BACalculator
//
//  Created by James Ungaretti on 8/17/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import DrinkKit
import Foundation

/// A persistent data manager for the drinker information in BACalculator.
class DrinkerManager: DiskManager<Drinker> {
    
    private var _drinker: Drinker?
    /// The `DrinkerInformation` managed by the `DrinkerInformationManager`.
    var drinker: Drinker? {
        return _drinker
    }
    
    /// The default `DrinkerInformationManager`.
    static var `default` = DrinkerManager(fileURL: FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!.appendingPathComponent("Drinker").appendingPathExtension("json"))
    
    /// Update and replace the `Drinker`.
    ///
    /// - Parameter drinkerInformation: The new `Drinker`.
    func update(drinker: Drinker) {
        _drinker = drinker
        saveToDisk(_drinker!)
    }
    
    /// Update the `weight` of the `drinker`. If `drinker` is `nil`, this method will do nothing.
    ///
    /// - Parameter weight: The new `weight`.
    func update(weight: Measurement<UnitMass>) {
        if _drinker != nil {
            _drinker!.weight = weight
            update(drinker: _drinker!)
        }
    }
    
    /// Update the `sex` of the `drinker`. If `drinker` is `nil`, this method will do nothing.
    ///
    /// - Parameter sex: The new `sex`.
    func update(sex: DrinkerSex) {
        if _drinker != nil {
            _drinker!.sex = sex
            update(drinker: _drinker!)
        }
    }
    
    /// Update the `alcoholMetabolism` of the `drinker`. If `drinker` is `nil`, this method will do nothing.
    ///
    /// - Parameter alcoholMetabolism: The new `alcoholMetabolism`.
    func update(alcoholMetabolism: DrinkerAlcoholMetabolism) {
        if _drinker != nil {
            _drinker!.alcoholMetabolism = alcoholMetabolism
            update(drinker: _drinker!)
        }
    }
    
}
