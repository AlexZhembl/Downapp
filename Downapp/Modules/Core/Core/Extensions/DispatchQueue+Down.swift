//
//  DispatchQueue+Down.swift
//  Core
//
//  Created by Alexey Zhemblouski on 25/10/2025.
//

import Foundation

public extension DispatchQueue {
    static func delay(_ delay: Double, queue: DispatchQueue = .main, execute: @escaping () -> Void) {
        queue.asyncAfter(
            deadline: .now() + delay,
            execute: execute
        )
    }
}
