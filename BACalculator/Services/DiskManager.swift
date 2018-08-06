//
//  DiskManager.swift
//  BACalculator
//
//  Created by James Ungaretti on 8/5/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import Foundation
import os.log

/// A `DiskManager` that stores data persistently in JSON files.
class DiskManager<T: Codable> {
    
    /// The URL of the file to store information in.
    let managedFileURL: URL
    /// The `Data` managed by the `DiskManager`.
    ///
    /// It is important to remeber that `managedData` is not saved to persistent storage when it is changed. To save `managedData`, use `saveToDisk()`.
    var managedData: T?
    
    /// Create a `DiskManager` with a specific file URL for storage.
    ///
    /// - Parameter fileURL: The URL of the the file to use for storage.
    init(fileURL: URL) {
        self.managedFileURL = fileURL
        loadFromDisk()
    }
    
    /// Update and save the `managedData` to a new value.
    ///
    /// - Parameter newValue: The new `managedData` value.
    func updateManaged(to newValue: T) {
        self.managedData = newValue
        saveToDisk()
    }
    
    /// Save the `managedData` to the specified `managedFileURL`.
    func saveToDisk() {
        let encoder = JSONEncoder()
        do {
            let encodedData = try encoder.encode(self.managedData)
            try FileManager.default.createDirectory(at: FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!, withIntermediateDirectories: true)
            try encodedData.write(to: self.managedFileURL)
            os_log("Saved %@ to %@.", "\(T.self)", self.managedFileURL.lastPathComponent)
        } catch {
            os_log("Unable to save %@ to %@.", "\(T.self)", self.managedFileURL.path)
        }
    }
    
    /// Load the contents of the specified `managedFileURL' to `managedData` as the specified type.
    func loadFromDisk() {
        let decoder = JSONDecoder()
        do {
            let encodedData = try Data(contentsOf: self.managedFileURL)
            self.managedData = try decoder.decode(T.self, from: encodedData)
            os_log("Loaded %@ from %@.", "\(T.self)", self.managedFileURL.lastPathComponent)
        } catch {
            self.managedData = nil
            os_log("Unable to load %@ from %@.", "\(T.self)", self.managedFileURL.path)
        }
    }
    
}
