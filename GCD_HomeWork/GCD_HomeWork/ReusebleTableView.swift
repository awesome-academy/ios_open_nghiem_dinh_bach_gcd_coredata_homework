//
//  ReusebleTableView.swift
//  GCD_HomeWork
//
//  Created by Bach Nghiem on 31/08/2023.
//

import UIKit
import Foundation

protocol ReusebleTableView: AnyObject {
    static var reuseIdentifier: String { get }
    static var nibName: String { get }
}

extension ReusebleTableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    static var nibName: String {
        return NSStringFromClass(self).components(separatedBy: ".").last ?? ""
    }
}
