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

    func testLiveEventsUpdatesCorrectly() throws {
        // create 3 (arbitrary) live events for testing
        var liveEventReference = [LiveEvent]()
        for _ in 0...2 {
            liveEventReference.append(randomLiveEventFactory())
        }
        
        // initialize mock server with the live events to return to the sut
        let mockServer = LiveEventRetrievingMock(completionHandlerData: .success(liveEventReference))
        
        let sut = LiveEventListManager(eventProvider: mockServer,
                                       storageProvider: DiskStorageService.shared)
        
        sut.refreshLiveEvents(with: nil)
        
        // make sure events in sut match live event reference
        XCTAssert(sut.events.count == liveEventReference.count)
        
        // make sure events in sut are in same order as reference
        for i in 0..<sut.events.count {
            XCTAssertTrue(sut.events[i].id == liveEventReference[i].id)
        }
    }
    
    // MARK: - Helper methods
    
    private func randomLiveEventFactory() -> LiveEvent {
        let venue = LiveEventVenue(name: UUID().uuidString,
                                   city: UUID().uuidString,
                                   state: UUID().uuidString)
        
        return LiveEvent(id: Int.random(in: 0...Int.max),
                                  title: UUID().uuidString,
                                  dateScheduled: Date(),
                                  venue: venue,
                                  performers: [])
    }

}
