//
//  ViewController.swift
//  GCD_HomeWork
//
//  Created by Bach Nghiem on 30/08/2023.
//

import UIKit

final class ViewController: UIViewController {
    @IBOutlet private weak var searchView: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var favouriteButton: UIButton!
    
    private var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        initUsers()
    }
    
    private func config() {
        tableView.delegate = self
        tableView.dataSource = self
        searchView.searchTextField.backgroundColor = .white
    }
    
    private func initUsers() {
        users = [User(avatar: "test", name: "Username", reposURL: "github.com/abcde"),
                 User(avatar: "test", name: "Username", reposURL: "github.com/123"),
                 User(avatar: "test", name: "Username", reposURL: "github.com/jqkl")]
    }
    
    @IBAction func handleFavouriteButton(_ sender: Any) {
        guard let viewController  = storyboard?.instantiateViewController(withIdentifier: "FavouriteViewController") as? FavouriteViewController else {
            return
        }
        navigationController?.pushViewController(viewController, animated: false)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let viewController  = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {
            return
        }
        viewController.user = users[indexPath.row]
        navigationController?.pushViewController(viewController, animated: false)
    }
}

extension ViewController: UITableViewDataSource {    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ProfileCell.self)
        let user = users[indexPath.section]
        cell.configCell(user: user)
        return cell
    }
}

