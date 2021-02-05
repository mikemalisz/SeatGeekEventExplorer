//
//  LiveEvent.swift
//  SeatGeekEventExplorer
//
//  Created by Mike Maliszewski on 2/4/21.
//

import Foundation

struct LiveEvent: Decodable {
    
    // MARK: User Driven
    
    var isFavorited = false
    
    // MARK: API Driven
    
    let id: Int
    
    let title: String
    
    let dateScheduled: Date
    
    let venue: LiveEventVenue
    
    let performers: [LiveEventPerformer]
    
}

// MARK: - Decoding JSON From Server

extension LiveEvent {
    /// Helps create a Date object from date time from the JSON server response
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        // date time format supplied from API
        formatter.dateFormat = "yyyy-MM-DD'T'HH:mm:ss"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
    
    private enum CodingKeys: String, CodingKey {
        case id, title, performers, venue
        
        case dateTimeUTC = "datetime_utc"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(Int.self, forKey: .id)
        title = try values.decode(String.self, forKey: .title)
        venue = try values.decode(LiveEventVenue.self, forKey: .venue)
        performers = try values.decode([LiveEventPerformer].self, forKey: .performers)
        
        // convert date time from API to Date object
        let rawDateTime = try values.decode(String.self, forKey: .dateTimeUTC)
        guard let date = LiveEvent.dateFormatter.date(from: rawDateTime) else {
            throw DecodingError.dataCorruptedError(forKey: CodingKeys.dateTimeUTC, in: values, debugDescription: "Failed to create date object")
        }
        dateScheduled = date
    }
}
