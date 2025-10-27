//
//  ProfilesDecisionStorage.swift
//  Features
//
//  Created by Alexey Zhemblouski on 25/10/2025.
//

import Utils

protocol ProfilesDecisionStorage {
    func storeDecision(_ decision: ProfilesDecision, for profile: Profile)
    func decision(for profile: Profile) -> ProfilesDecision?
    func resetStorage()
}

final class ProfilesDecisionStorageImpl: ProfilesDecisionStorage {
    private let store: StorageService
    
    init(store: StorageService) {
        self.store = store
    }
    
    func storeDecision(_ decision: ProfilesDecision, for profile: Profile) {
        store.save(decision, forKey: "\(profile.userId)")
    }
    
    func decision(for profile: Profile) -> ProfilesDecision? {
        store.load(ProfilesDecision.self, forKey: "\(profile.userId)")
    }
    
    func resetStorage() {
        store.clearAll()
    }
}

#if DEBUG
final class ProfilesDecisionStorageMock: ProfilesDecisionStorage {
    func storeDecision(_ decision: ProfilesDecision, for profile: Profile) {}
    func decision(for profile: Profile) -> ProfilesDecision? { nil }
    func resetStorage() {}
}
#endif
