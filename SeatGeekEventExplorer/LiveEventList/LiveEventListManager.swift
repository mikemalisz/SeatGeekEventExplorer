//
//  LiveEventListManager.swift
//  SeatGeekEventExplorer
//
//  Created by Mike Maliszewski on 2/7/21.
//

import Foundation

protocol LiveEventListManagerDelegate: AnyObject {
    func liveEventListManager(_ listManager: LiveEventListManager, errorDidOccur error: Error)
    func liveEventListManager(_ listManager: LiveEventListManager, liveEventsDidUpdate events: [LiveEvent])
}

class LiveEventListManager {
    private(set) var events = [LiveEvent]() {
        didSet {
            // notify delegate that events just updated
            delegate?.liveEventListManager(self, liveEventsDidUpdate: events)
        }
    }
    
    weak var delegate: LiveEventListManagerDelegate?
    
    private let eventProvider: LiveEventRetrieving
    
    private let storageProvider: DiskStorageService
    
    init(eventProvider: LiveEventRetrieving, storageProvider: DiskStorageService) {
        self.eventProvider = eventProvider
        self.storageProvider = storageProvider
    }
    
    func refreshLiveEvents(with query: String?) {
        eventProvider.retrieveEvents(with: query) { [weak self] (result) in
            // capture weak self to prevent retain cycles
            guard let self = self else { return }
            
            switch result {
            case .success(let newEvents):
                DispatchQueue.main.async {
                    self.events = newEvents
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.delegate?.liveEventListManager(self, errorDidOccur: error)
                }
                
            }
        }
    }
    
    func isFavorited(event: LiveEvent) -> Bool {
        return storageProvider.store.favoritedEventIds.contains(event.id)
    }
}
