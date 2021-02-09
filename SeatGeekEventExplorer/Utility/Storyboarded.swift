//
//  Storyboarded.swift
//  SeatGeekEventExplorer
//
//  Created by Mike Maliszewski on 2/8/21.
//

import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    /// Instnatiates an instance of `self` using the class's name as its identifier from the main storyboard
    static func instantiate() -> Self {
        // retrieve name of class
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".")[1]
        
        // instantiate class using its name
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}
