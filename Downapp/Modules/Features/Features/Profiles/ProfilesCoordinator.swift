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
    var storageService: StorageService { get }
}

public final class ProfilesCoordinator {
    @MainActor
    public static func makeProfilesView(deps: ProfilesDependencies) -> some View {
        let fetcher = ProfilesFetcherImpl(network: deps.networkService)
        let storage = ProfilesDecisionStorageImpl(store: deps.storageService)
        let viewModel = ProfilesViewModel(fetcher: fetcher, decisionStorage: storage)
        return ProfilesView(viewModel: viewModel)
    }
}
