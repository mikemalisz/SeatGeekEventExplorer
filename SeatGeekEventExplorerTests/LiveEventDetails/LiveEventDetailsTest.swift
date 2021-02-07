//
//  LiveEventDetailsTest.swift
//  SeatGeekEventExplorerTests
//
//  Created by Mike Maliszewski on 2/7/21.
//

import XCTest
@testable import SeatGeekEventExplorer

class LiveEventDetailsTest: XCTestCase {

    override func tearDownWithError() throws {
        DiskStorageService.shared.clearStorage()
    }
    
    func testEventIdBecomesFavorited() {
        let referenceEvent = TestUtility.randomLiveEventFactory()
        
        // system under test
        let sut = LiveEventDetailsManager(event: referenceEvent,
                                          storageProvider: DiskStorageService.shared)
        
        sut.toggleEventFavorited()
        
        XCTAssert(DiskStorageService.shared.store.favoritedEventIds.contains(referenceEvent.id))
    }
    
    func testEventIdBecomesUnfavorited() {
        let referenceEvent = TestUtility.randomLiveEventFactory()
        DiskStorageService.shared.store.favoritedEventIds.insert(referenceEvent.id)
        
        // system under test
        let sut = LiveEventDetailsManager(event: referenceEvent,
                                          storageProvider: DiskStorageService.shared)
        
        sut.toggleEventFavorited()
        
        XCTAssertFalse(DiskStorageService.shared.store.favoritedEventIds.contains(referenceEvent.id))
    }
    
    func testEventIsFavorited() {
        let referenceEvent = TestUtility.randomLiveEventFactory()
        DiskStorageService.shared.store.favoritedEventIds.insert(referenceEvent.id)
        
        // system under test
        let sut = LiveEventDetailsManager(event: referenceEvent,
                                          storageProvider: DiskStorageService.shared)
        
        XCTAssert(sut.isEventFavorited())
    }
    
    func testEventIsNotFavorited() {
        let referenceEvent = TestUtility.randomLiveEventFactory()
        
        // system under test
        let sut = LiveEventDetailsManager(event: referenceEvent,
                                          storageProvider: DiskStorageService.shared)
        
        XCTAssertFalse(sut.isEventFavorited())
    }
}
