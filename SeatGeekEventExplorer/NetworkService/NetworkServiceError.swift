//
//  NetworkServiceError.swift
//  SeatGeekEventExplorer
//
//  Created by Mike Maliszewski on 2/6/21.
//

import Foundation

enum NetworkServiceError: Error {
    case unknownError
    case serverResponseError
}

extension NetworkServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .unknownError:
            return NSLocalizedString("An unknown error has occurred", comment: String())
        case .serverResponseError:
            return NSLocalizedString("Received an error from server", comment: String())
        }
    }
}
