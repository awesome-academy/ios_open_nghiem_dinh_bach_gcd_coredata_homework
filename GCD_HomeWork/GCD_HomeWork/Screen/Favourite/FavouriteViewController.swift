//
//  FavouriteViewController.swift
//  GCD_HomeWork
//
//  Created by Bach Nghiem on 30/08/2023.
//

import UIKit

final class FavouriteViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var backButton: UIButton!
    
    private var accounts = [Account]()
    private var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        getFavouriteList()
    }
    
    private func configView() {
        navigationController?.isNavigationBarHidden = true
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func getFavouriteList() {
        let coreDataManager = CoreDataManager.shared
        users = coreDataManager.fetchUsers()
    }
    
    @IBAction private func handleBackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension FavouriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            let user = self.users[indexPath.row]
            let coreDataManager = CoreDataManager.shared
            let account = coreDataManager.convertUserToAccount(user: user)
            showToast(message: "Deleting \(user.name ?? "")  from favourite list successfully")
            coreDataManager.deleteUser(userAccount: account)
            users.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        default:
            break
        }
    }
}

extension FavouriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
    UITableViewCell {
        let cell = tableView.dequeueReusableCell(ProfileCell.self)
        let user = users[indexPath.row]
        let coreDataManager = CoreDataManager.shared
        let account = coreDataManager.convertUserToAccount(user: user)
        cell.configCell(account: account)
        return cell
    }
}
