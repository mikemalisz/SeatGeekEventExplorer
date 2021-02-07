//
//  LiveEventListManagerDelegateMock.swift
//  SeatGeekEventExplorerTests
//
//  Created by Mike Maliszewski on 2/7/21.
//

import Foundation
@testable import SeatGeekEventExplorer

class LiveEventListManagerDelegateMock: LiveEventListManagerDelegate {
    /// Hook called when error did occur delegate method is called
    var errorDidOccurAction: ((Error) -> Void)?
    
    /// Hook called when live events did update delegate method is called
    var liveEventsDidUpdateAction: (([LiveEvent]) -> Void)?
    
    func liveEventListManager(_ listManager: LiveEventListManager, errorDidOccur error: Error) {
        errorDidOccurAction?(error)
    }
    
    func liveEventListManager(_ listManager: LiveEventListManager, liveEventsDidUpdate events: [LiveEvent]) {
        liveEventsDidUpdateAction?(events)
    }
}
