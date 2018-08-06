//
//  PreferenceManager.swift
//  BACalculator
//
//  Created by James Ungaretti on 7/24/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import DrinkKit

/// A persistent storage manager for BACalculator's general app preferences.
class PreferenceManager {
    
    /// The default `PreferenceManager`. This `PreferenceManager` uses `UserDefaults.standard` to store data persistently.
    static var `default` = PreferenceManager(userDefaults: UserDefaults.standard)
    
    private let userDefaults: UserDefaults
    /// The Safe Mode preference.
    var safeMode: Bool {
        return userDefaults.bool(forKey: PreferenceManagerKeys.safeMode.stringValue)
    }
    /// If `true`, the user has customized their drinker information.
    var drinkerInformationConfigured: Bool {
        return userDefaults.bool(forKey: PreferenceManagerKeys.drinkerInformationConfigured.stringValue)
    }
    
    /// Create a `PreferenceManager` and specify which `UserDefaults` to use for storage.
    ///
    /// - Parameter userDefaults: The `UserDefaults` to use for storage.
    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
    
    /// Update the Safe Mode preference.
    ///
    /// - Parameter safeMode: The new Safe Mode preference.
    func setSafeMode(_ safeMode: Bool) {
        userDefaults.set(safeMode, forKey: PreferenceManagerKeys.safeMode.stringValue)
    }
    
    /// Update the drinker information configured preference.
    ///
    /// - Parameter drinkerInformationConfigured: The new drinker information configured preference.
    func setDrinkerInformationConfigured(_ drinkerInformationConfigured: Bool) {
        userDefaults.set(drinkerInformationConfigured, forKey: PreferenceManagerKeys.drinkerInformationConfigured.stringValue)
    }
    
}
