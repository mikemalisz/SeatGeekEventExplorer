//
//  LiveEventDetailsManager.swift
//  SeatGeekEventExplorer
//
//  Created by Mike Maliszewski on 2/7/21.
//

import Foundation

struct LiveEventDetailsManager {
    let event: LiveEvent
    
    let storageProvider: DiskStorageService
    
    func isEventFavorited() -> Bool {
        return storageProvider.store.favoritedEventIds.contains(event.id)
    }
    
    func toggleEventFavorited() {
        if storageProvider.store.favoritedEventIds.contains(event.id) {
            storageProvider.store.favoritedEventIds.remove(event.id)
        } else {
            storageProvider.store.favoritedEventIds.insert(event.id)
        }
    }
}
