//
//  Environment.swift
//  SeatGeekEventExplorer
//
//  Created by Mike Maliszewski on 2/4/21.
//

import Foundation

/// Access to environment variables provided by the current Scheme
struct Environment {
    static var seatGeekClientId: String? {
        ProcessInfo.processInfo.environment["SEATGEEK_CLIENT_ID"]
    }
    
    static var seatGeekClientSecret: String? {
        ProcessInfo.processInfo.environment["SEATGEEK_CLIENT_SECRET"]
    }
}
