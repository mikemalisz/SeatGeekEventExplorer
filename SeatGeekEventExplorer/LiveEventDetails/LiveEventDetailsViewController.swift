//
//  LiveEventDetailsViewController.swift
//  SeatGeekEventExplorer
//
//  Created by Mike Maliszewski on 2/9/21.
//

import UIKit

class LiveEventDetailsViewController: UIViewController, Storyboarded {
    
    // MARK: - Event Details
    
    var eventDetailsManager: LiveEventDetailsManager!
    
    private var event: LiveEvent {
        eventDetailsManager.event
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var detailImageView: UIImageView!
    
    @IBOutlet private weak var dateLabel: UILabel!
    
    @IBOutlet private weak var locationLabel: UILabel!
    
    private func configureViewFromEventDetails() {
        dateLabel.text = event.dateScheduled.description
        
        let location = "\(event.venue.city), \(event.venue.state)"
        locationLabel.text = location
    }
    
    // MARK: - Controller Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewFromEventDetails()
    }

}
