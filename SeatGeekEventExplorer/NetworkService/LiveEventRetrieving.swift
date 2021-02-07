//
//  LiveEventRetrieving.swift
//  SeatGeekEventExplorer
//
//  Created by Mike Maliszewski on 2/6/21.
//

import Foundation

protocol LiveEventRetrieving {
    typealias LiveEventServerResponse = (Result<[LiveEvent], Error>) -> Void
    
    /// Retrieves events with the given query from the server
    ///
    /// - Parameters:
    ///   - query: The query to provide the server for matching events
    ///   - completionHandler: A closure called once the server request has completed
    ///
    /// completionHandler may be called on a background thread
    func retrieveEvents(with query: String?, completionHandler: @escaping LiveEventServerResponse)
}
