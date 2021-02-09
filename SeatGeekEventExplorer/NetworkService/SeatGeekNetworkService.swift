//
//  SeatGeekNetworkService.swift
//  SeatGeekEventExplorer
//
//  Created by Mike Maliszewski on 2/6/21.
//

import UIKit

class SeatGeekNetworkService {
    
    // MARK: - Image Cache
    
    private var cachedImages = NSCache<NSURL, UIImage>()
    
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
            // make sure to call completion handler on main thread
            DispatchQueue.main.async {
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
        }
        
        task.resume()
    }
}

// MARK: - Image Retrieving

extension SeatGeekNetworkService: ImageRetrieving {
    func retrieveImage(at path: String, completionHandler: @escaping ImageServerResponse) {
        guard let url = NSURL(string: path) else { return }
        
        if let cachedImage = cachedImages.object(forKey: url) {
            // cached image exists, return it
            completionHandler(.success(cachedImage))
            return
        } else {
            // perform data task to retrieve image
            let task = URLSession.shared.dataTask(with: url as URL) { [weak self] (data, response, error) in
                DispatchQueue.main.async {
                    if let data = data, let response = response as? HTTPURLResponse {
                        // make sure status code from server was OK
                        guard response.statusCode == Constants.OKStatusCode else {
                            completionHandler(.failure(NetworkServiceError.serverResponseError))
                            return
                        }
                        
                        // decode image from server and call completion handler
                        guard let image = UIImage(data: data) else {
                            completionHandler(.failure(NetworkServiceError.imageConversionFailure))
                            return
                        }
                        self?.cachedImages.setObject(image, forKey: url)
                        completionHandler(.success(image))
                    } else if let error = error {
                        // error performing data task
                        completionHandler(.failure(error))
                    }
                }
            }
            task.resume()
        }
    }
}
