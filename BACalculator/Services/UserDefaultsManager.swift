//
//  UserDefaultsManager.swift
//  BACalculator
//
//  Created by James Ungaretti on 8/12/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import Foundation
import os.log

/// A generic persistent data manager for a certain `UserDefaults`.
class UserDefaultsManager<T: Codable>: Manager {
    
    /// The `UserDefaults` used for persistent storage.
    private let userDefaults: UserDefaults
    /// The key used to store the data in `UserDefaults`.
    private let key: String
    /// The data managed by the `UserDefaultsManager`.
    var managed: T? // TODO: Add didSet
    
    /// Create a `UserDefaultsManager` for a specific `UserDefaults` and attempt to load the managed data from that `UserDefaults`.
    ///
    /// - Parameters:
    ///   - userDefaults: The `UserDefaults` to use for persistent storage.
    ///   - key: The key to user within `UserDefaults`.
    init(userDefaults: UserDefaults, key: String) {
        self.userDefaults = userDefaults
        self.key = key
    }
    
    /// Update the managed data with a new value.
    ///
    /// - Parameter newManaged: The updated data.
    func updateManaged(_ newManaged: T) {
        self.managed = newManaged
        saveToUserDefaults()
    }

    /// Called before the managed data is saved to `userDefaults`.
    func willSaveToUserDefaults() {}
    
    /// Save the managed data to `userDefaults`.
    func saveToUserDefaults() {
        willSaveToUserDefaults()
        let encoder = JSONEncoder()
        do {
            let encoded = try encoder.encode(managed)
            userDefaults.set(encoded, forKey: key)
            didSaveToUserDefaults()
        } catch {
            didNotSaveToUserDefaults()
        }
    }
    
    /// Called after the managed data is successfully saved to `userDefaults`.
    func didSaveToUserDefaults() {
        os_log("%@ was saved to UserDefaults.", "\(T.self)")
    }
    
    /// Called when the managed data cannot be saved to `userDefaults`.
    func didNotSaveToUserDefaults() {
        os_log("%@ could not be saved to UserDefaults.", "\(T.self)")
    }
    
    /// Called before the managed data is save to `userDefaults`.
    func willLoadFromUserDefaults() {}
    
    /// Load the managed data from `userDefaults`.
    func loadFromUserDefaults() {
        willLoadFromUserDefaults()
        if let encoded = userDefaults.object(forKey: key) as? Data {
            let decoder = JSONDecoder()
            do {
                managed = try decoder.decode(T.self, from: encoded)
                didLoadFromUserDefaults()
            } catch {
                didNotLoadFromUserDefaults()
            }
        } else {
            didNotLoadFromUserDefaults()
        }
    }
    
    /// Called after the managed data is successfully loaded from `userDefaults`.
    func didLoadFromUserDefaults() {
        os_log("%@ was loaded from UserDefaults.", "\(T.self)")
    }
    
    /// Called when the managed data cannot be loaded from `userDefaults`.
    func didNotLoadFromUserDefaults() {
        os_log("%@ could not be loaded from UserDefaults.", "\(T.self)")
    }
    
}
