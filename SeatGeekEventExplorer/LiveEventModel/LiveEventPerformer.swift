//
//  LiveEventPerformer.swift
//  SeatGeekEventExplorer
//
//  Created by Mike Maliszewski on 2/4/21.
//

import Foundation

struct LiveEventPerformer: Decodable {
    let imagePath: String
    
    enum CodingKeys: String, CodingKey {
        case imagePath = "image"
    }
}
