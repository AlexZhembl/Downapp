//
//  ProfilesDecisionStorageTests.swift
//  DownappTests
//
//  Created by Alexey Zhemblouski on 25/10/2025.
//

import XCTest
@testable import Features
@testable import Utils

final class ProfilesDecisionStorageTests: XCTestCase {
    
    private var storageService: StorageServiceMock!
    private var decisionStorage: ProfilesDecisionStorageImpl!
    private var testProfile: Profile!
    
    override func setUp() {
        super.setUp()
        
        storageService = StorageServiceMock()
        decisionStorage = ProfilesDecisionStorageImpl(store: storageService)
    }
    
    override func tearDown() {
        storageService = nil
        decisionStorage = nil
        
        super.tearDown()
    }
    
    func testStoreDecision() {
        let decision: ProfilesDecision = .positive
        let userId = 123
        
        decisionStorage.storeDecision(decision, for: Profile.test(userId: 123))
        
        XCTAssertEqual(storageService.decigion, decision)
        XCTAssertEqual(storageService.key, "\(userId)")
    }
    
    func testDecisionForProfileWhenEmptyStorage() {
        let userId = 123

        let decision = decisionStorage.decision(for: Profile.test(userId: userId))

        XCTAssertNil(decision)
    }
    
    func testDecisionForProfileWhenNotEmptyStorage() {
        let decision: ProfilesDecision = .positive
        let userId = 123
        storageService.key = "\(userId)"
        storageService.decigion = decision

        let result = decisionStorage.decision(for: Profile.test(userId: 123))

        XCTAssertEqual(decision, result)
    }
    
    func testResetStorage() {
        decisionStorage.resetStorage()
        
        XCTAssertTrue(storageService.clearAllCalled)
        XCTAssertNil(storageService.key)
    }
}

private extension Profile {
    static func test(userId: Int) -> Self {
        .init(
            name: "",
            userId: userId,
            age: 123,
            location: "",
            about: "",
            profilePictureURL: URL.applicationDirectory
        )
    }
}

private class StorageServiceMock: StorageService {
    var decigion: ProfilesDecision!
    var key: String?
    
    var clearAllCalled = false

    func save<T>(_ object: T, forKey key: String) where T : Encodable {
        decigion = object as? ProfilesDecision
        self.key = key
    }
    
    func load<T>(_ type: T.Type, forKey key: String) -> T? where T : Decodable {
        if self.key == key {
            return decigion as? T
        } else {
            return nil
        }
    }
    
    func remove(forKey key: String) {
    }
    
    func clearAll() {
        key = nil
        clearAllCalled = true
    }
}
