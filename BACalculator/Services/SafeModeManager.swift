//
//  SafeModeManager.swift
//  BACalculator
//
//  Created by James Ungaretti on 8/12/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import Foundation

class SafeModeManager: UserDefaultsManager<Bool> {
    
    /// The default `SafeModeManager`.
    static var `default` = SafeModeManager(userDefaults: UserDefaults.standard, key: "safeMode")
    
    /// The safe mode preference managed by the `SafeModeManager`.
    var safeMode: Bool {
        if let managed = self.managed {
            return managed
        } else {
            return false
        }
    }
    
    /// Update the safe mode preference.
    ///
    /// - Parameter safeMode: The new safe mode preference.
    func update(safeMode: Bool) {
        updateManaged(safeMode)
    }
    
}
