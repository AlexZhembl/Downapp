//
//  ProfileModel+UI.swift
//  Features
//
//  Created by Alexey Zhemblouski on 25/10/2025.
//

import Foundation

extension Profile: Identifiable {
    var id: Int { userId }
}

extension Profile: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(userId)
    }
    
    static func == (lhs: Profile, rhs: Profile) -> Bool {
        lhs.userId == rhs.userId
    }
}

#if DEBUG
extension Profile {
    static func mock(id: Int) -> Self {
        .init(
            name: "Helen",
            userId: id,
            age: 18,
            location: "Paris",
            about: "lorem ipsum...",
            profilePictureURL: URL(
                string: "https://down-static.s3.us-west-2.amazonaws.com/picks_filter/female_v2/pic00000.jpg"
            )!
        )
    }
}
#endif
