//
//  ProfileCell.swift
//  GCD_HomeWork
//
//  Created by Bach Nghiem on 30/08/2023.
//

import UIKit

final class ProfileCell: UITableViewCell,ReusebleTableView {
    @IBOutlet private weak var userImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var repoLabel: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        config()
    }
    
    private func config() {
        userImageView.setRadius()
        contentView.layer.cornerRadius = LayoutOptions.radius
        contentView.clipsToBounds = true
    }
    
    func configCell(user: User) {
        userImageView.image = UIImage(named: user.avatar)
        nameLabel.text = user.name
        repoLabel.text = user.reposURL
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
