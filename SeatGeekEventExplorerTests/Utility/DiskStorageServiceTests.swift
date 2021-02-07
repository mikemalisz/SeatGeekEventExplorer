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
        DiskStorageService.shared.clearStorage()
    }

    func testClearStorageWorks() throws {
        let sut = DiskStorageService()
        sut.store.favoritedEventIds.insert(Int.random(in: 0...Int.max))
        
        sut.clearStorage()
        
        XCTAssert(sut.store.favoritedEventIds.isEmpty)
    }
    
    func testStorageIsPersisted() {
        let testSet = Set([Int.random(in: 0...Int.max), Int.random(in: 0...Int.max)])
        
        var sut = DiskStorageService()
        sut.store.favoritedEventIds = testSet
        
        // saves value to disk and creates
        // new instance to read back from disk
        sut.saveLocalStoreToDisk()
        sut = DiskStorageService()
        
        XCTAssert(sut.store.favoritedEventIds == testSet)
    }

}
