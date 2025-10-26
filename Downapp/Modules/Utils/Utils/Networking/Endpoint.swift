//
//  Endpoint.swift
//  Networking
//
//  Created by Alexey Zhemblouski on 25/10/2025.
//

import Foundation

public enum Endpoint {
    case profiles
    
    var url: URL? {
        switch self {
        case .profiles:
            return URL(string: "https://raw.githubusercontent.com/downapp/sample/main/sample.json")
        }
    }
}
