//
//  UIViewController.swift
//  GCD_HomeWork
//
//  Created by Bach Nghiem on 05/09/2023.
//

import UIKit
import Foundation

extension UIViewController {
    func showToast(message: String, duration: TimeInterval = 2.0) {
        let toastHeight: CGFloat = 50
        let toastView = CustomToastView()
        toastView.translatesAutoresizingMaskIntoConstraints = false
        toastView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        toastView.layer.cornerRadius = 10
        toastView.messageLabel.text = message
        
        self.view.addSubview(toastView)
        
        NSLayoutConstraint.activate([
            toastView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            toastView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            toastView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            toastView.heightAnchor.constraint(equalToConstant: toastHeight)
        ])
        
        UIView.animate(withDuration: 0.5, delay: duration, options: .curveEaseOut, animations: {
            toastView.alpha = 0
        }) { _ in
            toastView.removeFromSuperview()
        }
    }
}
