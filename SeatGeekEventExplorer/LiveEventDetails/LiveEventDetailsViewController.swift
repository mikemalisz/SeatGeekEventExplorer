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
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    @IBOutlet private weak var detailImageView: UIImageView!
    
    @IBOutlet private weak var dateLabel: UILabel!
    
    @IBOutlet private weak var locationLabel: UILabel!
    
    private func configureViewFromEventDetails() {
        titleLabel.text = event.title
        dateLabel.text = event.dateScheduled.description
        
        locationLabel.text = Constants.formatLocation(with: event.venue.city,
                                                      state: event.venue.state)
    }
    
    // MARK: - Bar button
    
    private let heartButton = ToggleableHeartButton()
    
    private func configureRightBarButton() {
        heartButton.addTarget(self, action: #selector(userDidPressFavoriteButton), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: heartButton)
        navigationItem.rightBarButtonItem = barButton
    }
    
    @objc
    private func userDidPressFavoriteButton() {
        eventDetailsManager.toggleEventFavorited()
        heartButton.isHeartImageFilled = eventDetailsManager.isEventFavorited()
    }
    
    // MARK: - Controller Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = Constants.navigationTitle
        configureViewFromEventDetails()
        configureRightBarButton()
    }
    
    // MARK: - Types
    
    private struct Constants {
        static let navigationTitle = "Event Details"
        
        static func formatLocation(with city: String, state: String) -> String {
            return "\(city), \(state)"
        }
    }

}
