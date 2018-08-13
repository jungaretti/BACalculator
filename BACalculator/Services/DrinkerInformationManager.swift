//
//  DrinkerInformationManager.swift
//  BACalculator
//
//  Created by James Ungaretti on 8/12/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import Foundation
import DrinkKit

/// The persistent storage manager for drinker information in
class DrinkerInformationManager: DiskManager<DrinkerInformation> {
    
    /// The default `DrinkerInformationManager`.
    static var `default` = DrinkerInformationManager(fileURL: FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!.appendingPathComponent("DrinkerInformation").appendingPathExtension("json"))
    
    /// The `DrinkerInformation` managed by the `DrinkerInformationManager`.
    var drinkerInformation: DrinkerInformation? {
        return managed
    }
    
    /// Update the `drinkerInformation` managed by the `DrinkerInformationManager`.
    ///
    /// - Parameter newDrinkerInformation: The new `DrinkerInformation`.
    func update(drinkerInformation newDrinkerInformation: DrinkerInformation) {
        super.updateManaged(newDrinkerInformation)
    }
    
    /// Update the `weight` of the `drinkerInformation` managed by the `DrinkerInformationManager`. If `drinkerInformation` is `nil`, nothing will change.
    ///
    /// - Parameter newWeight: The new `weight`.
    func update(weight newWeight: Measurement<UnitMass>) {
        var drinkerInformation = self.drinkerInformation
        drinkerInformation?.weight = newWeight
        if let newDrinkerInformation = drinkerInformation { update(drinkerInformation: newDrinkerInformation) }
    }
    
    /// Update the `sex` of the `drinkerInformation` managed by the `DrinkerInformationManager`. If `drinkerInformation` is `nil`, nothing will change.
    ///
    /// - Parameter newSex: The new `sex`.
    func update(sex newSex: DrinkerSex) {
        var drinkerInformation = self.drinkerInformation
        drinkerInformation?.sex = newSex
        if let newDrinkerInformation = drinkerInformation { update(drinkerInformation: newDrinkerInformation) }
    }
    
    /// Update the `sex` of the `drinkerInformation` managed by the `DrinkerInformationManager`. If `drinkerInformation` is `nil`, nothing will change.
    ///
    /// - Parameter newSex: The new `sex`.
    func update(alcoholMetabolism newAlcoholMetabolism: DrinkerAlcoholMetabolism) {
        var drinkerInformation = self.drinkerInformation
        drinkerInformation?.alcoholMetabolism = newAlcoholMetabolism
        if let newDrinkerInformation = drinkerInformation { update(drinkerInformation: newDrinkerInformation) }
    }
    
}
