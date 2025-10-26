//
//  dfd.swift
//  Core
//
//  Created by Alexey Zhemblouski on 25/10/2025.
//

public extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}
