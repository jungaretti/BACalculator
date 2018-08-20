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
    /// The `JSONEncoder` to use for encode operations.
    private var jsonEncoder: JSONEncoder = JSONEncoder()
    /// The `JSONDecoder` to use for decode operations.
    private var jsonDecoder: JSONDecoder = JSONDecoder()
    
    /// Create a `UserDefaultsManager` for a specific `UserDefaults` and attempt to load the managed data from that `UserDefaults`.
    ///
    /// - Parameters:
    ///   - userDefaults: The `UserDefaults` to use for persistent storage.
    ///   - key: The key to user within `UserDefaults`.
    init(userDefaults: UserDefaults, key: String) {
        self.userDefaults = userDefaults
        self.key = key
    }

    /// Called before the managed data is saved to `userDefaults`.
    func willSaveToUserDefaults() {}
    
    /// Save `Codable` data to the `userDefaults` of the `UserDefaultsManager`.
    ///
    /// Before data is saved to `UserDefaults`, `willSaveToUserDefaults()` is called. After data is saved successfully, `didSaveToUserDefaults()` is called. If data cannot be saved to `UserDefaults`, `didNotSaveToUserDefaults()` is called.
    ///
    /// - Parameter data: The `Codable` to save to disk.
    final func saveToUserDefaults(_ data: T) {
        DispatchQueue.main.async {
            self.willSaveToUserDefaults()
            do {
                let encodedData = try self.jsonEncoder.encode(data)
                self.userDefaults.set(encodedData, forKey: self.key)
                self.didSaveToUserDefaults()
            } catch {
                self.didNotSaveToUserDefaults()
            }
        }
    }
    
    /// Called after the managed data is successfully saved to `userDefaults`.
    func didSaveToUserDefaults() {
        os_log("%@ was saved to %@ in UserDefaults.", "\(T.self)", key)
    }
    
    /// Called when the managed data cannot be saved to `userDefaults`.
    func didNotSaveToUserDefaults() {
        os_log("%@ could not be saved to %@ in UserDefaults.", "\(T.self)", key)
    }
    
    /// Called before the managed data is save to `userDefaults`.
    func willLoadFromUserDefaults() {}
    
    /// Load `Codable` data from the `userDefaults` of the `UserDefaultsManager`.
    ///
    /// Before data is loaded from disk, `willLoadFromDisk()` is called. After data is loaded successfully, `didLoadFromDisk()` is called. If data cannot be loaded from disk, `didNotLoadFromDisk(withError:)` is called.
    ///
    /// - Returns: The data loaded from disk, or `nil` if an error occured.
    final func loadFromDisk() -> T? {
        willLoadFromUserDefaults()
        if let encodedData = userDefaults.object(forKey: key) as? Data {
            do {
                let decodedData = try jsonDecoder.decode(T.self, from: encodedData)
                didSaveToUserDefaults()
                return decodedData
            } catch {
                didNotSaveToUserDefaults()
                return nil
            }
        } else {
            didNotLoadFromUserDefaults()
            return nil
        }
    }
    
    /// Called after the managed data is successfully loaded from `userDefaults`.
    func didLoadFromUserDefaults() {
        os_log("%@ was loaded from %@ in UserDefaults.", "\(T.self)", key)
    }
    
    /// Called when the managed data cannot be loaded from `userDefaults`.
    func didNotLoadFromUserDefaults() {
        os_log("%@ could not be loaded from %@ in UserDefaults.", "\(T.self)", key)
    }
    
}
