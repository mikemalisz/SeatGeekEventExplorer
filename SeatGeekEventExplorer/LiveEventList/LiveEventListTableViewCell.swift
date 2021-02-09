//
//  LiveEventListTableViewCell.swift
//  SeatGeekEventExplorer
//
//  Created by Mike Maliszewski on 2/8/21.
//

import UIKit

class LiveEventListTableViewCell: UITableViewCell {
    
    // MARK: - Images
    
    @IBOutlet private weak var previewImageView: UIImageView! {
        didSet {
            previewImageView.layer.cornerRadius = 15
        }
    }
    
    func setPreviewImage(with image: UIImage) {
        previewImageView.image = image
    }
    
    func setIsHeartIconVisible(_ isVisible: Bool) {
        favoritedImageView.isHidden = !isVisible
    }
    
    private lazy var favoritedImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: Constants.heartIconName))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: Constants.heartIconSize),
            imageView.widthAnchor.constraint(equalToConstant: Constants.heartIconSize),
            imageView.topAnchor.constraint(equalTo: previewImageView.topAnchor, constant: Constants.heartIconOffset),
            imageView.leadingAnchor.constraint(equalTo: previewImageView.leadingAnchor, constant: Constants.heartIconOffset)
        ])
        return imageView
    }()
    
    // MARK: - Title
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    func setTitle(with title: String) {
        titleLabel.text = title
    }
    
    // MARK: - Location
    
    @IBOutlet private weak var locationLabel: UILabel!
    
    func setLocation(withCity city: String, state: String) {
        locationLabel.text = "\(city), \(state)"
    }
    
    // MARK: - Date
    
    @IBOutlet private weak var dateLabel: UILabel!
    
    func setDate(with date: Date) {
        dateLabel.text = date.description
    }
    
    // MARK: - Types
    
    private struct Constants {
        static let heartIconSize: CGFloat = 25
        static let heartIconOffset = -1*(heartIconSize / 3)
        static let heartIconName = "filled-heart-icon"
    }
}
