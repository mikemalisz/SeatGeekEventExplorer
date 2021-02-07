//
//  FileManager+getDocumentsDirectory.swift
//  SeatGeekEventExplorer
//
//  Created by Mike Maliszewski on 2/6/21.
//

import Foundation

extension FileManager {
    /// Returns the URL to the device's documents directory
    static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
