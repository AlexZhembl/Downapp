//
//  DownappApp.swift
//  Downapp
//
//  Created by Alexey Zhemblouski on 25/10/2025.
//

import SwiftUI

@main
struct DownappApp: App {
    
    private let coordinator = AppCoordinator()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                coordinator.start()
            }
        }
    }
}
