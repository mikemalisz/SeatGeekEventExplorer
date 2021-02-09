//
//  LiveEventDetailsViewController.swift
//  SeatGeekEventExplorer
//
//  Created by Mike Maliszewski on 2/9/21.
//

import UIKit

class LiveEventDetailsViewController: UIViewController, Storyboarded {
    
    // MARK: - Dependencies
    
    var eventDetailsManager: LiveEventDetailsManager!
    
    private var event: LiveEvent {
        eventDetailsManager.event
    }
    
    var imageProvider: ImageRetrieving!
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    @IBOutlet private weak var detailImageView: UIImageView!
    
    @IBOutlet private weak var dateLabel: UILabel!
    
    @IBOutlet private weak var locationLabel: UILabel!
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    private func configureViewFromEventDetails() {
        titleLabel.text = event.title
        dateLabel.text = dateFormatter.string(from: event.dateScheduled)
        
        locationLabel.text = Constants.formatLocation(with: event.venue.city,
                                                      state: event.venue.state)
        
        if let performer = event.performers.first {
            imageProvider.retrieveImage(at: performer.imagePath) { [weak self] (result) in
                guard case .success(let image) = result else {
                    return
                }
                self?.detailImageView.image = image.roundedCorners()
            }
        }
    }
    
    // MARK: - Bar button
    
    private let heartButton = ToggleableHeartButton()
    
    private func configureRightBarButton() {
        heartButton.isHeartImageFilled = eventDetailsManager.isEventFavorited()
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
