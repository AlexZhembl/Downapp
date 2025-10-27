//
//  ProfileViewModel.swift
//  Features
//
//  Created by Alexey Zhemblouski on 25/10/2025.
//

import Combine
import Core
import Foundation

@MainActor
final class ProfilesViewModel: ObservableObject {
    
    enum States {
        case idle
        case loading
        case loaded([Profile])
        case outOfProfiles
        case failed(Error)
    }
    
    @Published var state: States = .idle
    
    private let fetcher: ProfilesFetcher
    private let decisionStorage: ProfilesDecisionStorage
    
    init(fetcher: ProfilesFetcher, decisionStorage: ProfilesDecisionStorage) {
        self.fetcher = fetcher
        self.decisionStorage = decisionStorage
    }
    
    func viewDidAppear() {
        guard case .idle = state else {
            return
        }
        
        loadProfiles()
    }
    
    func decisionReceived(_ decision: ProfilesDecision, for profileIndex: Int) {
        guard case var .loaded(profiles) = state,
              let profile = profiles[safe: profileIndex] else {
            assertionFailure("No profiles with such index: \(profileIndex)")
            return
        }
        
        decisionStorage.storeDecision(decision, for: profile)
        profiles.remove(at: profileIndex)
        
        if profiles.isEmpty {
            state = .outOfProfiles
        } else {
            state = .loaded(profiles)
        }
    }
    
    func retryLoading() {
        loadProfiles()
    }
    
    func resetProfiles() {
        decisionStorage.resetStorage()
        loadProfiles()
    }
    
    private func loadProfiles() {
        state = .loading

        Task { @MainActor in
            do {
                let profiles = try await fetcher.fetchProfiles()
                    .filter { decisionStorage.decision(for: $0) == nil }
                    
                fetcher.prefetchPics(for: profiles)
                
                state = profiles.isEmpty ? .outOfProfiles : .loaded(profiles)
            } catch {
                state = .failed(error)
            }
        }
    }
}
