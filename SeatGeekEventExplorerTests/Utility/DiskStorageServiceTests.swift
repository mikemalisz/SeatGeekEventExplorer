//
//  DiskStorageServiceTests.swift
//  SeatGeekEventExplorerTests
//
//  Created by Mike Maliszewski on 2/6/21.
//

import XCTest
@testable import SeatGeekEventExplorer

class DiskStorageServiceTests: XCTestCase {
    
    override func tearDownWithError() throws {
        DiskStorageService.shared.clearLocalStorage()
        DiskStorageService.shared.saveLocalStoreToDisk()
    }

    func testClearStorageWorks() throws {
        let sut = DiskStorageService()
        sut.store.favoritedKeys.insert(UUID().uuidString)
        
        sut.clearLocalStorage()
        
        XCTAssert(sut.store.favoritedKeys.isEmpty)
    }
    
    func testStorageIsPersisted() {
        let testSet = Set([UUID().uuidString, UUID().uuidString])
        
        var sut = DiskStorageService()
        sut.store.favoritedKeys = testSet
        
        // saves value to disk and creates
        // new instance to read back from disk
        sut.saveLocalStoreToDisk()
        sut = DiskStorageService()
        
        XCTAssert(sut.store.favoritedKeys == testSet)
    }

}
