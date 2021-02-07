//
//  SeatGeekNetworkService.swift
//  SeatGeekEventExplorer
//
//  Created by Mike Maliszewski on 2/6/21.
//

import Foundation

class SeatGeekNetworkService {
    
    // MARK: - Helper methods
    
    private func createURLComponent(for endpoint: String, with query: String?) -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = Constants.scheme
        urlComponents.host = Constants.seatGeekHost
        urlComponents.path = endpoint
        
        var queryItems = [
            URLQueryItem(name: Constants.clientIdParameter, value: Environment.seatGeekClientId),
            URLQueryItem(name: Constants.clientSecretParameter, value: Environment.seatGeekClientSecret)
        ]
        
        if let query = query {
            queryItems.append(URLQueryItem(name: Constants.queryParameter, value: query))
        }
        
        urlComponents.queryItems = queryItems
        return urlComponents
    }
    
    // MARK: - Types
    
    private struct EventServerResponse: Decodable {
        let events: [LiveEvent]
    }
    
    private struct Constants {
        static let clientIdParameter = "client_id"
        static let clientSecretParameter = "client_secret"
        static let queryParameter = "q"
        
        static let scheme = "https"
        static let seatGeekHost = "api.seatgeek.com"
        static let eventsEndpoint = "/2/events/"
        static let OKStatusCode = 200
    }
}

// MARK: - Live Event Retrieving Implementation

extension SeatGeekNetworkService: LiveEventRetrieving {
    func retrieveEvents(with query: String?, completionHandler: @escaping LiveEventServerResponse) {
        // url setup
        let urlComponents = createURLComponent(for: Constants.eventsEndpoint, with: query)
        
        guard let url = urlComponents.url else {
            assertionFailure("Expecting valid URL")
            completionHandler(.failure(NetworkServiceError.unknownError))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let response = response as? HTTPURLResponse {
                // make sure status code from server was OK
                guard response.statusCode == Constants.OKStatusCode else {
                    completionHandler(.failure(NetworkServiceError.serverResponseError))
                    return
                }
                
                // decode data from server and call completion handler
                do {
                    let eventResponse = try JSONDecoder().decode(EventServerResponse.self, from: data)
                    completionHandler(.success(eventResponse.events))
                } catch {
                    completionHandler(.failure(error))
                }
            } else if let error = error {
                // error performing data task
                completionHandler(.failure(error))
            }
        }
        
        task.resume()
    }
}
