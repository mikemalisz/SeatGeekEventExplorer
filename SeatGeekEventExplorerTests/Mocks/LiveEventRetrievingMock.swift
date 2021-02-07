//
//  LiveEventRetrievingMock.swift
//  SeatGeekEventExplorerTests
//
//  Created by Mike Maliszewski on 2/7/21.
//

import Foundation
@testable import SeatGeekEventExplorer

struct LiveEventRetrievingMock: LiveEventRetrieving {
    /// Hook for intercepting data passed to retrieve events method
    let retrieveEventsAction: (_ query: String?) -> Void
    
    /// A result object to use when calling completion handler of methods
    let completionHandlerData: Result<[LiveEvent], Error>
    
    func retrieveEvents(with query: String?, completionHandler: @escaping LiveEventServerResponse) {
        // call hook to make sure the parameters provided are correct
        retrieveEventsAction(query)
        
        // pass the completion handler data we were given back to the caller
        completionHandler(completionHandlerData)
    }
}
