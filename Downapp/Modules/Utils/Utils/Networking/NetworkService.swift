//
//  NetworkService.swift
//  Networking
//
//  Created by Alexey Zhemblouski on 25/10/2025.
//

import Foundation

public enum NetworkError: Error {
    case badURL
    case requestFailed
    case decodingFailed
}

public protocol NetworkService {
    func requestData(from url: URL) async throws -> Data
    func request<T: Decodable>(_ endpoint: Endpoint, as type: T.Type) async throws -> T
}

public final class NetworkServiceImpl: NetworkService {
    
    public init() {}
    
    public func requestData(from url: URL) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw NetworkError.requestFailed
        }
        
        return data
    }
    
    public func request<T: Decodable>(_ endpoint: Endpoint, as type: T.Type) async throws -> T {
        guard let url = endpoint.url else { throw NetworkError.badURL }
        
        let data = try await requestData(from: url)
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }
    }
}
