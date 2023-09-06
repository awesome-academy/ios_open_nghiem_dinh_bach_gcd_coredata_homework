//
//  CustomToastView.swift
//  GCD_HomeWork
//
//  Created by Bach Nghiem on 05/09/2023.
//

import Foundation
import UIKit

final class CustomToastView: UIView {
    let messageLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = UIColor.black.withAlphaComponent(0.7)
        layer.cornerRadius = Utils.Margin.cornerRadius
        
        messageLabel.textAlignment = .center
        messageLabel.textColor = .white
        messageLabel.font = UIFont.systemFont(ofSize: Utils.Margin.labelFontSize)
        addSubview(messageLabel)
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: Utils.Margin.topMargin),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Utils.Margin.leadingMargin),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Utils.Margin.trailingMargin),
            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Utils.Margin.bottomMargin)
        ])
    }
}

