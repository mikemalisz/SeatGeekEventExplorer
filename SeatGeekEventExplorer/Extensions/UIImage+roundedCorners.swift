//
//  UIImage+roundedCorners.swift
//  SeatGeekEventExplorer
//
//  Created by Mike Maliszewski on 2/9/21.
//

import UIKit

extension UIImage {
    func roundedCorners(with radius: CGFloat = 15) -> UIImage? {
        let rect = CGRect(origin: CGPoint(), size: size)
        UIGraphicsBeginImageContext(size)
        UIBezierPath(roundedRect: rect, cornerRadius: radius).addClip()
        draw(in: rect)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
