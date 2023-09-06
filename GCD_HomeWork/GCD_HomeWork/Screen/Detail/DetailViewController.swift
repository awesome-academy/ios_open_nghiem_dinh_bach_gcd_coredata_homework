//
//  DetailViewController.swift
//  GCD_HomeWork
//
//  Created by Bach Nghiem on 30/08/2023.
//

import CoreData
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
    @IBOutlet private weak var followersLabel: UILabel!
    @IBOutlet private weak var repositoryLabel: UILabel!
    @IBOutlet private weak var followingLabel: UILabel!
    
    private var accounts = [Account]()
    var userAccount: Account?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let account = userAccount {
            getFollowers(followerURL: account.followersURL)
            getProfileDetail(profileURL: account.url)
            let coreDataManager = CoreDataManager.shared
            let imageName = coreDataManager.isExistInFavouriteList(name: account.login) ? Utils.Image.heartFullImageName : Utils.Image.heartImageName
            favouriteButton.setImage(UIImage(systemName: imageName), for: .normal)
        }
        configView()
    }
    
    @IBAction private func handleBackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction private func handleFavouriteButton(_ sender: Any) {
        if let account = userAccount {
            let coreDataManager = CoreDataManager.shared
            if coreDataManager.isExistInFavouriteList(name: account.login) {
                coreDataManager.deleteUser(userAccount: account)
                showToast(message: "Removing \(account.login) from favourite list successfully")
                favouriteButton.setImage(UIImage(systemName: Utils.Image.heartImageName), for: .normal)
            } else {
                coreDataManager.addUser(userAccount: account)
                showToast(message: "Adding \(account.login) to  favourite list successfully")
                favouriteButton.setImage(UIImage(systemName: Utils.Image.heartFullImageName), for: .normal)
            }
        }
    }
    
    private func configView() {
        navigationController?.isNavigationBarHidden = true
        favouriteButton.setRadius()
        tableView.dataSource = self
        userImageView.setRadius()
        stackView.setRadius(radius: LayoutOptions.radius)
        descriptionLabel.numberOfLines = 2
        descriptionLabel.lineBreakMode = .byWordWrapping
    }
    
    private func getProfileDetail(profileURL: String) {
        let queue = DispatchQueue(label: "profileQueue", qos: .utility)
        queue.async { [unowned self] in
            APIRepository.shared.fetchProfile(profileURL: profileURL) { (account: Account) in
                self.loadDataForView(account: account)
                self.tableView.reloadData()
            }
        }
    }
    
    private func getFollowers(followerURL: String) {
        let queue = DispatchQueue(label: "followQueue", qos: .utility)
        queue.async { [unowned self] in
            APIRepository.shared.fetchFollowers(followerURL: followerURL) { (itemList: [Account]) in
                _ = itemList.map { item in
                    self.accounts.append(item)
                }
                self.tableView.reloadData()
            }
        }
    }
    
    private func loadDataForView(account: Account) {
        loadImage(image: account.avatarURL)
        nameLabel.text = account.name
        descriptionLabel.text = account.location
        if let followersCount = account.followers {
            followersLabel.text = String(followersCount)
        }
        
        if let followingCount = account.following {
            followingLabel.text = String(followingCount)
        }
        
        if let reposCount = account.publicRepos {
            repositoryLabel.text = String(reposCount)
        }
    }
    
    private func loadImage(image: String) {
        APIRepository.shared.loadImage(stringURL: image) { (data: Data) in
            DispatchQueue.main.async { [weak self] in
                self?.userImageView.image = UIImage(data: data)
            }
        }
    }
}

extension DetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(FollowCell.self)
        let account = accounts[indexPath.row]
        cell.configCell(account: account)
        return cell
    }
}


