//
//  AppDependences.swift
//  Downapp
//
//  Created by Alexey Zhemblouski on 25/10/2025.
//

import Core
import Features
import Foundation
import Utils

final class AppDependencies {
    let networkService: NetworkService
    let storageService: StorageService

    init() {
        self.networkService = NetworkServiceImpl()
        self.storageService = StorageServiceImpl(defaults: .standard)
    }
}

extension AppDependencies: ProfilesDependencies { }
