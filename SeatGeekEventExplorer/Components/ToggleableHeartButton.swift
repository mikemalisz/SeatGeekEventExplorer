//
//  ToggleableHeartButton.swift
//  SeatGeekEventExplorer
//
//  Created by Mike Maliszewski on 2/9/21.
//

import UIKit

class ToggleableHeartButton: UIButton {
    
    var isHeartImageFilled = false {
        didSet {
            configureHeartImage()
        }
    }
    
    private lazy var heartImageView: UIImageView = {
        // configure image view
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        // constrain to view
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            imageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5),
            imageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
        return imageView
    }()
    
    // MARK: - Initialization
    
    init() {
        super.init(frame: .zero)
        configureHeartImage()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureHeartImage()
    }

    private func configureHeartImage() {
        let imageName = isHeartImageFilled
            ? Constants.filledHeartIcon
            : Constants.unfilledHeartIcon
        
        heartImageView.image = UIImage(named: imageName)
    }
    
    // MARK: - Types
    
    private struct Constants {
        static let unfilledHeartIcon = "unfilled-heart-icon"
        static let filledHeartIcon = "filled-heart-icon"
    }
}
