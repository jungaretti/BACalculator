//
//  DiskManager.swift
//  BACalculator
//
//  Created by James Ungaretti on 8/17/18.
//  Copyright © 2018 James Ungaretti. All rights reserved.
//

import Foundation
import os.log

/// A generic persistent data manager that stores `Codable` data to a certain `URL`.
class DiskManager<T: Codable> {
    
    /// The `URL` of the file to use for persistent storage.
    let fileURL: URL
    /// The `FileManager` to use for read and write operation.
    private let fileManager: FileManager
    /// The `JSONEncoder` to use for encode operations.
    private var jsonEncoder: JSONEncoder
    /// The `JSONDecoder` to use for decode operations.
    private var jsonDecoder: JSONDecoder
    
    /// Create a `DiskManager` for a certain `URL`.
    ///
    /// - Parameter fileURL: The `URL` of the file to use for persistent storage.
    init(fileURL: URL) {
        self.fileURL = fileURL
        self.fileManager = FileManager.default
        self.jsonEncoder = JSONEncoder()
        self.jsonDecoder = JSONDecoder()
    }
    
    /// Tells the `DiskManager` that data will be saved to disk.
    func willSaveToDisk() {}
    
    /// Save `Codable` data to the `fileURL` of the `DiskManager`.
    ///
    /// Before data is saved to disk, `willSaveToDisk()` is called. After data is saved successfully, `didSaveToDisk()` is called. If data cannot be saved to disk, `didNotSaveToDisk(withError:)` is called.
    ///
    /// - Parameter data: The `Codable` to save to disk.
    final func saveToDisk(_ data: T) {
        DispatchQueue.main.async {
            self.willSaveToDisk()
            do {
                let encodedData = try self.jsonEncoder.encode(data)
                self.fileManager.createFile(atPath: self.fileURL.path, contents: encodedData, attributes: nil)
                self.didSaveToDisk()
            } catch {
                self.didNotSaveToDisk(withError: error)
            }
        }
    }
    
    /// Tells the `DiskManager` that data was saved to disk.
    func didSaveToDisk() {
        os_log("%@ was saved to %@.", "\(T.self)", fileURL.lastPathComponent)
    }
    
    /// Tells the `DiskManager` that data could not be saved to disk because of an error.
    ///
    /// - Parameter error: The `Error` that prevented data from being saved to disk.
    func didNotSaveToDisk(withError error: Error?) {
        os_log("%@ could not be saved to %@.", "\(T.self)", fileURL.path)
    }
    
    /// Tells the `DiskManager` that data will be loaded from disk.
    func willLoadFromDisk() {}
    
    /// Load `Codable` data from the `fileURL` of the `DiskManager`.
    ///
    /// Before data is loaded from disk, `willLoadFromDisk()` is called. After data is loaded successfully, `didLoadFromDisk()` is called. If data cannot be loaded from disk, `didNotLoadFromDisk(withError:)` is called.
    ///
    /// - Returns: The data loaded from disk, or `nil` if an error occured.
    final func loadFromDisk() -> T? {
        willLoadFromDisk()
        if let encodedData = fileManager.contents(atPath: fileURL.path) {
            do {
                let decodedData = try jsonDecoder.decode(T.self, from: encodedData)
                didLoadFromDisk()
                return decodedData
            } catch {
                didNotLoadFromDisk(withError: error)
                return nil
            }
        } else {
            didNotLoadFromDisk(withError: nil)
            return nil
        }
    }
    
    /// Tells the `DiskManager` that data was loaded from disk.
    func didLoadFromDisk() {
        os_log("%@ was loaded from %@.", "\(T.self)", fileURL.lastPathComponent)
    }
    
    /// Tells the `DiskManager` that data was not loaded from disk.
    ///
    /// - Parameter error: The `Error` that prevented data from being loaded from disk.
    func didNotLoadFromDisk(withError error: Error?) {
        os_log("%@ could not be loaded from %@.", "\(T.self)", fileURL.path)
    }
    
}
