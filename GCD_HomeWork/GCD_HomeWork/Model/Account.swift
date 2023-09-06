//
//  Account.swift
//  GCD_HomeWork
//
//  Created by Bach Nghiem on 03/09/2023.
//

import Foundation

struct Account: Codable {
    var login: String
    var avatarURL: String
    var htmlURL: String
    var url: String
    var bio: String?
    var followersURL: String
    var followers: Int?
    var following: Int?
    var publicRepos: Int?
    var name: String?
    var location: String?
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
        case htmlURL = "html_url"
        case url
        case bio
        case followersURL = "followers_url"
        case followers
        case following
        case publicRepos = "public_repos"
        case name
        case location
    }
}


