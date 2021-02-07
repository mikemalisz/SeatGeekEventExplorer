//
//  DiskStorageService.swift
//  SeatGeekEventExplorer
//
//  Created by Mike Maliszewski on 2/6/21.
//

import Foundation

class DiskStorageService {
    static let shared = DiskStorageService()
    
    /// Container for stored values this object manages
    var store = StorageContainer()
    
    private var fileURL = FileManager
        .getDocumentsDirectory()
        .appendingPathComponent(Constants.storageFilename)
    
    init() {
        updateLocalStoreFromDisk()
    }
    
    // MARK: - Disk Storage Handlers
    
    /// Clears local and disk storage
    func clearLocalStorage() {
        store = StorageContainer()
    }
    
    func saveLocalStoreToDisk() {
        do {
            let encodedData = try JSONEncoder().encode(store)
            try encodedData.write(to: fileURL)
        } catch {
            print(error)
            assertionFailure()
        }
    }
    
    private func updateLocalStoreFromDisk() {
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            return
        }
        
        do {
            let data = try Data(contentsOf: fileURL)
            let decodedStore = try JSONDecoder().decode(StorageContainer.self, from: data)
            store = decodedStore
        } catch {
            print(error)
            assertionFailure()
        }
    }
    
    // MARK: - Types
    
    struct StorageContainer: Codable {
        var favoritedKeys: Set<String>
        
        init(favoritedKeys: Set<String> = .init()) {
            self.favoritedKeys = favoritedKeys
        }
    }
    
    private struct Constants {
        static let storageFilename = "DiskStorageFile"
    }
}
