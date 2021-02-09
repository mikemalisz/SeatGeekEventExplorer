//
//  UITableViewCell+cellIdentifier.swift
//  SeatGeekEventExplorer
//
//  Created by Mike Maliszewski on 2/8/21.
//

import UIKit

extension UITableViewCell {
    var cellIdentifier: String {
        // retrieve name of class
        let fullName = NSStringFromClass(Self.self)
        return fullName.components(separatedBy: ".")[1]
    }
}
