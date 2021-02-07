//
//  DiskStorageService.swift
//  SeatGeekEventExplorer
//
//  Created by Mike Maliszewski on 2/6/21.
//

import Foundation

class DiskStorageService {
    static let shared = DiskStorageService()
    
    let dictionaryStore = [String: Any]()
    
    private init() {
        
    }
    
    private struct Constants {
    }
}
