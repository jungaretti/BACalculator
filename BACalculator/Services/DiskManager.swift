//
//  DiskManager.swift
//  BACalculator
//
//  Created by James Ungaretti on 8/12/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import Foundation
import os.log

/// A generic persistent data manager for a certain file `URL`. A `Codable` type is read from and written to this `URL`.
class DiskManager<T: Codable>: Manager {
    
    /// The `FileManager` used for file read and write operations.
    private let fileManager: FileManager
    /// The `URL` of the file being managed.
    private let fileURL: URL
    /// The data managed by the `DiskManager`.
    var managed: T? // TODO: Add didSet
    
    /// Create a `DiskManager` for a specific `URL` and attempt to load the managed data from that `URL`.
    ///
    /// - Parameter fileURL: The `URL` of the file being managed by the `DiskManager`.
    init(fileURL: URL) {
        self.fileManager = FileManager.default
        self.fileURL = fileURL
        loadFromDisk()
    }
    
    /// Update the managed data with a new value.
    ///
    /// - Parameter newManaged: The updated data.
    func updateManaged(_ newManaged: T) {
        self.managed = newManaged
        saveToDisk()
    }
    
    /// Called before the managed data is saved to the disk.
    func willSaveToDisk() {}
    
    /// Save the managed data to the disk at the specified `URL`.
    func saveToDisk() {
        willSaveToDisk()
        let encoder = JSONEncoder()
        do {
            let encoded = try encoder.encode(managed)
            fileManager.createFile(atPath: fileURL.path, contents: encoded, attributes: nil)
            didSaveToDisk()
        } catch {
            didNotSaveToDisk()
        }
    }
    
    /// Called after the managed data is successfully saved to the disk.
    func didSaveToDisk() {
        os_log("%@ was saved to %@.", "\(T.self)", fileURL.lastPathComponent)
    }
    
    /// Called when the managed data cannot be saved to the disk.
    func didNotSaveToDisk() {
        os_log("%@ could not be saved to %@.", type: .error, "\(T.self)", fileURL.path)
    }
    
    /// Called before the managed data is load from the disk.
    func willLoadFromDisk() {}
    
    /// Load the managed data from the disk at the specified `URL`.
    func loadFromDisk() {
        willLoadFromDisk()
        if let encoded = fileManager.contents(atPath: fileURL.path) {
            let decoder = JSONDecoder()
            do {
                managed = try decoder.decode(T.self, from: encoded)
                didLoadFromDisk()
            } catch {
                didNotLoadFromDisk()
            }
        } else {
            didNotLoadFromDisk()
        }
    }
    
    /// Called when the managed data is successfully loaded from the disk.
    func didLoadFromDisk() {
        os_log("%@ was loaded from %@.", "\(T.self)", fileURL.lastPathComponent)
    }
    
    /// Called when the managed data cannot be loaded from the disk.
    func didNotLoadFromDisk() {
        managed = nil
        os_log("%@ could not be loaded from %@", type: .error, "\(T.self)", fileURL.path)
    }
    
}
