//
//  LiveEventRetrieving.swift
//  SeatGeekEventExplorer
//
//  Created by Mike Maliszewski on 2/6/21.
//

import Foundation

protocol LiveEventRetrieving {
    typealias LiveEventServerResponse = (Result<[LiveEvent], Error>) -> Void
    
    func retrieveEvents(with query: String, completionHandler: @escaping LiveEventServerResponse)
}
