//
//  ProfileModel.swift
//  Features
//
//  Created by Alexey Zhemblouski on 25/10/2025.
//

import Foundation

struct Profile: Decodable {
    let name: String
    let userId: Int
    let age: Int
    let location: String
    let about: String
    let profilePictureURL: URL

    enum CodingKeys: String, CodingKey {
        case name
        case userId = "user_id"
        case age
        case location = "loc"
        case about = "about_me"
        case profilePictureURL = "profile_pic_url"
    }
}
