//
//  AppCoordinator.swift
//  Downapp
//
//  Created by Alexey Zhemblouski on 25/10/2025.
//

import Combine
import Features
import SwiftUI
import UI
import Utils

final class AppCoordinator: ObservableObject {
    enum Feature {
        case profiles
    }
    
    @Published private var currentFeature: Feature = .profiles
    
    private let dependencies: AppDependencies

    init() {
        self.dependencies = AppDependencies()
    }

    @ViewBuilder
    func start() -> some View {
        switch currentFeature {
        case .profiles:
            ProfilesCoordinator.makeProfilesView(deps: dependencies)
        }
    }
}
