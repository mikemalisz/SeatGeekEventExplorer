//
//  LiveEventListManagerTests.swift
//  SeatGeekEventExplorerTests
//
//  Created by Mike Maliszewski on 2/7/21.
//

import XCTest
@testable import SeatGeekEventExplorer

class LiveEventListManagerTests: XCTestCase {
    
    override func tearDownWithError() throws {
        DiskStorageService.shared.clearStorage()
    }
    
    func testServerQueryIsCorrect() {
        let queryReference = UUID().uuidString
        
        var mockServer = LiveEventRetrievingMock()
        
        var didCallRetrieveEvents = false
        mockServer.retrieveEventsAction = { query in
            didCallRetrieveEvents = true
            XCTAssert(query == queryReference)
        }
        
        // system under test
        let sut = LiveEventListManager(eventProvider: mockServer,
                                       storageProvider: DiskStorageService.shared)
        
        sut.refreshLiveEvents(with: queryReference)
        
        XCTAssert(didCallRetrieveEvents)
    }
    
    func testIsEventFavorited() {
        let event = TestUtility.randomLiveEventFactory()
        let mockServer = LiveEventRetrievingMock()
        
        // system under test
        let sut = LiveEventListManager(eventProvider: mockServer,
                                       storageProvider: DiskStorageService.shared)
        
        // make sure event is not initially favorited
        XCTAssertFalse(sut.isFavorited(event: event))
        
        // insert and make sure event is now favorited
        DiskStorageService.shared.store.favoritedEventIds.insert(event.id)
        XCTAssert(sut.isFavorited(event: event))
    }
    
    func testIsEventReturnedCorrectly() {
        let event = TestUtility.randomLiveEventFactory()
        let mockServer = LiveEventRetrievingMock(completionHandlerData: .success([event]))
        
        // system under test
        let sut = LiveEventListManager(eventProvider: mockServer,
                                       storageProvider: DiskStorageService.shared)
        XCTAssertNil(sut.event(for: 0))
        
        sut.refreshLiveEvents(with: nil)
        
        XCTAssertNotNil(sut.event(for: 0))
        XCTAssertNil(sut.event(for: 1))
        XCTAssertNil(sut.event(for: -1))
    }

    func testLiveEventsUpdatesCorrectly() {
        // create 3 (arbitrary) live events for testing
        var liveEventReference = [LiveEvent]()
        for _ in 0...2 {
            liveEventReference.append(TestUtility.randomLiveEventFactory())
        }
        
        // initialize mock server with the live events to return to the sut
        let mockServer = LiveEventRetrievingMock(completionHandlerData: .success(liveEventReference))
        
        // system under test
        let sut = LiveEventListManager(eventProvider: mockServer,
                                       storageProvider: DiskStorageService.shared)
        
        sut.refreshLiveEvents(with: nil)
        
        // make sure same number of events between sut and reference
        XCTAssert(sut.events.count == liveEventReference.count)
        
        // make sure events in sut are in same order as reference
        for i in 0..<sut.events.count {
            XCTAssertTrue(sut.events[i].id == liveEventReference[i].id)
        }
    }
    
    func testLiveEventDelegateCalledOnEventsUpdate() {
        // create 3 (arbitrary) live events for testing
        var liveEventReference = [LiveEvent]()
        for _ in 0...2 {
            liveEventReference.append(TestUtility.randomLiveEventFactory())
        }
        
        // initialize mock server with the live events to return to the sut
        let mockServer = LiveEventRetrievingMock(completionHandlerData: .success(liveEventReference))
        let mockDelegate = LiveEventListManagerDelegateMock()
        
        // system under test
        let sut = LiveEventListManager(eventProvider: mockServer,
                                       storageProvider: DiskStorageService.shared)
        sut.delegate = mockDelegate
        
        // implement hooks to test if delegate is called on mock delegate
        var didCallLiveEventsActions = false
        mockDelegate.liveEventsDidUpdateAction = { events in
            didCallLiveEventsActions = true
            XCTAssert(sut.events.count == liveEventReference.count)
            for i in 0..<sut.events.count {
                XCTAssertTrue(sut.events[i].id == liveEventReference[i].id)
            }
        }
        
        mockDelegate.errorDidOccurAction = { _ in
            XCTFail("Error action shouldn't be called")
        }
        
        // perform test
        sut.refreshLiveEvents(with: nil)
        
        XCTAssert(didCallLiveEventsActions)
    }
    
    func testErrorDelegateCalledOnError() {
        let referenceError = NetworkServiceError.serverResponseError
        
        let mockServer = LiveEventRetrievingMock(completionHandlerData: .failure(referenceError))
        let mockDelegate = LiveEventListManagerDelegateMock()
        
        // system under test
        let sut = LiveEventListManager(eventProvider: mockServer,
                                       storageProvider: DiskStorageService.shared)
        sut.delegate = mockDelegate
        
        // implement hooks for delegate
        mockDelegate.liveEventsDidUpdateAction = { _ in
            XCTFail("Events did update action shouldn't be called")
        }
        
        var didCallErrorAction = false
        mockDelegate.errorDidOccurAction = { error in
            didCallErrorAction = true
            XCTAssert((error as? NetworkServiceError) == referenceError)
        }
        
        // perform test
        sut.refreshLiveEvents(with: nil)
        
        XCTAssert(didCallErrorAction)
    }

}
