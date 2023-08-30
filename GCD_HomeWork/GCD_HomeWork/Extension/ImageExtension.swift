//
//  ImageExtension.swift
//  GCD_HomeWork
//
//  Created by Bach Nghiem on 31/08/2023.
//

import UIKit
import Foundation

extension UIImageView {
    func setRadius() {
        layer.cornerRadius = self.bounds.height / 2
        clipsToBounds = true
    }
}
