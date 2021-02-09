//
//  LiveEventListManager.swift
//  SeatGeekEventExplorer
//
//  Created by Mike Maliszewski on 2/7/21.
//

import UIKit

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
    
    private let imageProvider: ImageRetrieving
    
    private let storageProvider: DiskStorageService
    
    init(eventProvider: LiveEventRetrieving, imageProvider: ImageRetrieving, storageProvider: DiskStorageService) {
        self.eventProvider = eventProvider
        self.imageProvider = imageProvider
        self.storageProvider = storageProvider
    }
    
    // MARK: - Intents
    
    func refreshLiveEvents(with query: String?) {
        eventProvider.retrieveEvents(with: query) { [weak self] (result) in
            // capture weak self to prevent retain cycles
            guard let self = self else { return }
            
            switch result {
            case .success(let newEvents):
                self.events = newEvents
            case .failure(let error):
                self.delegate?.liveEventListManager(self, errorDidOccur: error)
                
            }
        }
    }
    
    func retrieveImage(at path: String, completionHandler: @escaping (Result<UIImage, Error>) -> Void) {
        imageProvider.retrieveImage(at: path, completionHandler: completionHandler)
    }
    
    func isFavorited(event: LiveEvent) -> Bool {
        return storageProvider.store.favoritedEventIds.contains(event.id)
    }
    
    func event(for index: Int) -> LiveEvent? {
        guard (index >= 0) && (index < events.count) else {
            return nil
        }
        return events[index]
    }
}
