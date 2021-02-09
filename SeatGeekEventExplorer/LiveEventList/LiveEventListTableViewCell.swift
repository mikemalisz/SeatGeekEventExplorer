//
//  LiveEventListTableViewCell.swift
//  SeatGeekEventExplorer
//
//  Created by Mike Maliszewski on 2/8/21.
//

import UIKit

class LiveEventListTableViewCell: UITableViewCell {
    
    // MARK: - Image Preview
    
    @IBOutlet private weak var previewImageView: UIImageView!
    
    func setPreviewImage(with image: UIImage) {
        previewImageView.image = image
    }
    
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
    
}
