//
//  ViewController.swift
//  GCD_HomeWork
//
//  Created by Bach Nghiem on 30/08/2023.
//

import UIKit

final class HomeViewController: UIViewController {
    @IBOutlet private weak var searchView: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var favouriteButton: UIButton!
    
    private var accounts = [Account]()
    private var filteredData = [Account]()
    private var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        getAccounts()
    }
    
    private func config() {
        tableView.delegate = self
        tableView.dataSource = self
        searchView.delegate = self
        searchView.searchTextField.backgroundColor = .white
    }
    
    private func getAccounts() {
        let queue = DispatchQueue(label: "userQueue", qos: .utility)
        queue.async { [unowned self] in
            APIRepository.shared.fetchUsers() { (itemList: [Account]) in
                _ = itemList.map { item in
                    self.accounts.append(item)
                }
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func handleFavouriteButton(_ sender: Any) {
        guard let viewController  = storyboard?.instantiateViewController(withIdentifier: "FavouriteViewController") as? FavouriteViewController else {
            return
        }
        navigationController?.pushViewController(viewController, animated: false)
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let viewController  = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {
            return
        }
        let account = accounts[indexPath.row]
        viewController.account = account
        navigationController?.pushViewController(viewController, animated: false)
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching { return filteredData.count } else { return accounts.count }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ProfileCell.self)
        cell.delegate = self
        isSearching ? cell.configCell(account: filteredData[indexPath.row]) : cell.configCell(account: accounts[indexPath.row])
        return cell
    }
}

extension ViewController: UserCellDelegate {
    func userButtonTapped(sender: UIButton) {
        guard let viewController  = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {
            return
        }
        let cell = sender.superview?.superview as! ProfileCell
        let cellIndex = self.tableView.indexPath(for: cell)
        if let indexPath = cellIndex{
            let account = accounts[indexPath.row]
            viewController.account = account
        }
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = accounts.filter({ $0.login.lowercased().prefix(searchText.count) == searchText.lowercased() })
        isSearching = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearching = false
        filteredData.removeAll()
    }
}
