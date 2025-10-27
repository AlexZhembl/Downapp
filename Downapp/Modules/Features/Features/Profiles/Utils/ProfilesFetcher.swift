//
//  ProfileService.swift
//  Features
//
//  Created by Alexey Zhemblouski on 25/10/2025.
//

import Foundation
import Utils

protocol ProfilesFetcher {
    func fetchProfiles() async throws -> [Profile]
    func prefetchPics(for profiles: [Profile])
}

final class ProfilesFetcherImpl: ProfilesFetcher {
    private let network: NetworkService
    
    init(network: NetworkService) {
        self.network = network
    }
    
    func fetchProfiles() async throws -> [Profile] {
        try await network.request(.profiles, as: [Profile].self)
    }
    
    func prefetchPics(for profiles: [Profile]) {
        // As far as we use `AsycnImage` to show the pics,
        // we gonna prepare `URLSession.shared` inside `NetworkService`
        // to use cached versions of the pics
        profiles
            .map(\.profilePictureURL)
            .forEach { url in
                Task.detached { [weak self] in
                    do {
                        _ = try await self?.network.requestData(from: url)
                        print("profile pic has been pre-fetched for \(url.lastPathComponent)")
                    } catch {
                        print("Failed to pre-fetch image for \(url.lastPathComponent): \(error)")
                    }
                }
            }
    }
}

#if DEBUG
final class ProfilesFetcherMock: ProfilesFetcher {
    func fetchProfiles() async throws -> [Profile] { [
        .mock(id: 1), .mock(id: 2), .mock(id: 3)
    ] }
    func prefetchPics(for profiles: [Profile]) {}
}
#endif
