//
//  Collection+Down.swift
//  Core
//
//  Created by Alexey Zhemblouski on 25/10/2025.
//

public extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
