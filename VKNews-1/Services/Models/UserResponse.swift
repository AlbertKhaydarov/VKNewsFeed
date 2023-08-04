//
//  UserResponse.swift
//  VKNews-1
//
//  Created by Альберт Хайдаров on 03.08.2023.
//

import Foundation

struct UserResponseWrapped: Decodable {
    let response: [UserResponse]
}

struct UserResponse: Decodable {
    let photo100: String?
}
