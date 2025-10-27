//
//  ProfilesDecision+UI.swift
//  Features
//
//  Created by Alexey Zhemblouski on 25/10/2025.
//

import SwiftUI

extension ProfilesDecision {
    var color: Color {
        switch self {
        case .positive:
            return .blue
        case .negative:
            return .red
        }
    }
    
    var icon: Image {
        switch self {
        case .positive:
            return Image(systemName: "heart.fill")
            
        case .negative:
            return Image(systemName: "flame.fill")
        }
    }
    
    var text: String {
        switch self {
        case .positive:
            return "Date"
            
        case .negative:
            return "Down"
        }
    }
}
