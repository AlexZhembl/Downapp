//
//  ProfileCoordinator.swift
//  Features
//
//  Created by Alexey Zhemblouski on 25/10/2025.
//

import SwiftUI
import Utils

public protocol ProfilesDependencies {
    var networkService: NetworkService { get }
}

public final class ProfilesCoordinator {
    @MainActor
    public static func makeProfilesView(deps: ProfilesDependencies) -> some View {
        // TODO
        Text("TODO")
    }
}
