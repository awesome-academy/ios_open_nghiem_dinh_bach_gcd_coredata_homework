//
//  DetailViewController.swift
//  GCD_HomeWork
//
//  Created by Bach Nghiem on 30/08/2023.
//

import UIKit

final class DetailViewController: UIViewController {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var userImageView: UIImageView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var favouriteButton: UIButton!
    
    private var users = [User]()
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = user {
            userImageView.image = UIImage(named: user.avatar)
            nameLabel.text = user.name
            descriptionLabel.text = user.reposURL
        }
        config()
        initUsers()
    }
    
    @IBAction private func handleBackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    private func config() {
        navigationController?.isNavigationBarHidden = true
        favouriteButton.setRadius()
        tableView.dataSource = self
        userImageView.setRadius()
        stackView.setRadius(radius: LayoutOptions.radius)
    }
    
    private func initUsers() {
        users = [User(avatar: "test", name: "Username", reposURL: "github.com/abcde"),
                 User(avatar: "test", name: "Username", reposURL: "github.com/123"),
                 User(avatar: "test", name: "Username", reposURL: "github.com/jqkl")]
    }
}

extension DetailViewController: UITableViewDataSource {    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(FollowCell.self)
        let user = users[indexPath.row]
        cell.configCell(user: user)
        return cell
    }
}


