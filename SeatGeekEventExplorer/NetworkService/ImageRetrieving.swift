//
//  ImageRetrieving.swift
//  SeatGeekEventExplorer
//
//  Created by Mike Maliszewski on 2/9/21.
//

import UIKit

typealias ImageServerResponse = (Result<UIImage, Error>) -> Void

protocol ImageRetrieving {
    func retrieveImage(at path: String, completionHandler: @escaping ImageServerResponse)
}
