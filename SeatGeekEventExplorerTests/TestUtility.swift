//
//  TestUtility.swift
//  SeatGeekEventExplorerTests
//
//  Created by Mike Maliszewski on 2/7/21.
//

import Foundation
@testable import SeatGeekEventExplorer

class TestUtility {
    static func randomLiveEventFactory() -> LiveEvent {
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
