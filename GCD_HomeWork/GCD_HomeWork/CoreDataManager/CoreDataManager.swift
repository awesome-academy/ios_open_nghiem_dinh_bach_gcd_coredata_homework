//
//  CoreDataManager.swift
//  GCD_HomeWork
//
//  Created by Bach Nghiem on 05/09/2023.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private let persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "CoreDataModel")
        persistentContainer.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
    }
    
    func addUser(userAccount: Account) {
        let user = User(context: persistentContainer.viewContext)
        user.avatarURL = userAccount.avatarURL
        user.followersURL = userAccount.followersURL
        user.name = userAccount.login
        user.repoURL = userAccount.htmlURL
        saveContext()
    }
    
    func fetchUsers() -> [User] {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        do {
            let users = try persistentContainer.viewContext.fetch(fetchRequest)
            return users
        } catch {
            print("Error fetching users: \(error)")
            return []
        }
    }
    
    func deleteUser(userAccount: Account) {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", userAccount.login)
        do {
            let matchingUsers = try persistentContainer.viewContext.fetch(fetchRequest)
            if let userToDelete = matchingUsers.first {
                persistentContainer.viewContext.delete(userToDelete)
                saveContext()
            }
        } catch {
            print("Error fetching or deleting user: \(error)")
        }
    }
    
    func isExistInFavouriteList(name: String) -> Bool {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        do {
            let matchingUsers = try persistentContainer.viewContext.fetch(fetchRequest)
            return !matchingUsers.isEmpty
        } catch {
            print("Error fetching items: \(error)")
            return false
        }
    }
    
    func convertUserToAccount(user: User) -> Account {
        return Account(
            login: user.name ?? "",
            avatarURL: user.avatarURL ?? "",
            htmlURL: user.repoURL ?? "",
            url: user.infoURL ?? "",
            bio: "",
            followersURL: user.followersURL ?? "",
            followers: 0,
            following: 0,
            publicRepos: 0,
            name: "",
            location: ""
        )
    }
    
    private func saveContext() {
        do {
            try persistentContainer.viewContext.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
}
