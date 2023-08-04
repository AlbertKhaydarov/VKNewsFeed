//
//  API.swift
//  VKNews
//
//  Created by Admin on 19.06.2023.
//

import Foundation

struct API {
    static let scheme = "https"
    static let host = "api.vk.com"
    static let version = "5.131"

    static let newsFeed = "/method/newsfeed.get"    
    static let user = "/method/users.get"
}

