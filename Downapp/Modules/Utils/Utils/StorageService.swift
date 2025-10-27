//
//  StorageService.swift
//  Core
//
//  Created by Alexey Zhemblouski on 25/10/2025.
//

import Foundation

public protocol StorageService {
    func save<T: Encodable>(_ object: T, forKey key: String)
    func load<T: Decodable>(_ type: T.Type, forKey key: String) -> T?
    
    func remove(forKey key: String)
    func clearAll()
}

public final class StorageServiceImpl: StorageService {
    
    private let defaults: UserDefaults
    
    public init(defaults: UserDefaults) {
        self.defaults = defaults
    }
    
    public func save<T: Encodable>(_ object: T, forKey key: String) {
        do {
            let data = try JSONEncoder().encode(object)
            defaults.set(data, forKey: key)
        } catch {
            print("StorageService: Failed to encode object for key \(key): \(error)")
        }
    }
    
    public func load<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
        guard let data = defaults.data(forKey: key) else { return nil }
        do {
            let object = try JSONDecoder().decode(T.self, from: data)
            return object
        } catch {
            print("StorageService: Failed to decode object for key \(key): \(error)")
            return nil
        }
    }
    
    public func remove(forKey key: String) {
        defaults.removeObject(forKey: key)
    }
    
    public func clearAll() {
        for (key, _) in defaults.dictionaryRepresentation() {
            defaults.removeObject(forKey: key)
        }
    }
}
