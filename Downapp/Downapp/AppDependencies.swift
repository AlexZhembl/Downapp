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

    init() {
        self.networkService = NetworkServiceImpl()
    }
}

extension AppDependencies: ProfilesDependencies { }
