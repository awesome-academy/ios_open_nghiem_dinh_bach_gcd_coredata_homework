//
//  UIStackViewExtension.swift
//  GCD_HomeWork
//
//  Created by Bach Nghiem on 31/08/2023.
//

import UIKit
import Foundation

extension UIStackView {
    func setRadius(radius: CGFloat) {
        layer.cornerRadius = radius
        clipsToBounds = true
    }
}
