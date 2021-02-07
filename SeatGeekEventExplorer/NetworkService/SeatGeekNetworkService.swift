//
//  SeatGeekNetworkService.swift
//  SeatGeekEventExplorer
//
//  Created by Mike Maliszewski on 2/6/21.
//

import Foundation

class SeatGeekNetworkService: LiveEventRetrieving {
    func retrieveEvents(with query: String?, completionHandler: @escaping LiveEventServerResponse) {
        // url setup
        var urlComponents = URLComponents()
        urlComponents.scheme = Constants.scheme
        urlComponents.host = Constants.seatGeekHost
        urlComponents.path = Constants.eventsEndpoint
        
        // query item setup
        var queryItems = [
            URLQueryItem(name: Constants.clientIdParameter, value: Environment.seatGeekClientId),
            URLQueryItem(name: Constants.clientSecretParameter, value: Environment.seatGeekClientSecret)
        ]
        
        if let query = query {
            queryItems.append(URLQueryItem(name: Constants.queryParameter, value: query))
        }
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            assertionFailure("Expecting valid URL")
            completionHandler(.failure())
            return
        }
        
    }
    
    private struct Constants {
        static let clientIdParameter = "client_id"
        static let clientSecretParameter = "client_secret"
        static let queryParameter = "q"
        
        static let scheme = "https"
        static let seatGeekHost = "api.seatgeek.com"
        static let eventsEndpoint = "/2/events/"
    }
}
