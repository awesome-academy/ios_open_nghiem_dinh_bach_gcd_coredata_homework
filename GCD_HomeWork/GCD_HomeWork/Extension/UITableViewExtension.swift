//
//  UITableViewExtension.swift
//  GCD_HomeWork
//
//  Created by Bach Nghiem on 31/08/2023.
//

import UIKit
import Foundation

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(_ type: T.Type) -> T where T: ReusebleTableView {
        print(T.reuseIdentifier)
        guard let cell =  self.dequeueReusableCell(withIdentifier: T.reuseIdentifier) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
    
    func register<T: UITableViewCell>(nibName name: T.Type, atBundle bundleClass: AnyClass? = nil) where T: ReusebleTableView {
        let identifier = T.reuseIdentifier
        let nibName = T.nibName
        
        var bundle: Bundle? = nil
        if let bundleName = bundleClass {
            bundle = Bundle(for: bundleName)
        }
        register(UINib(nibName: nibName, bundle: bundle), forCellReuseIdentifier: identifier)
    }
}
