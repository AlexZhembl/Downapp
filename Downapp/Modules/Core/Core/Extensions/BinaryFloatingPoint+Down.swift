//
//  BinaryFloatingPoint+Down.swift
//  Core
//
//  Created by Alexey Zhemblouski on 25/10/2025.
//

public extension BinaryFloatingPoint {
    func normalized(from range: ClosedRange<Self>) -> Self {
        guard range.lowerBound != range.upperBound else { return 0 }
        let clampedValue = self.clamped(to: range)
        return (clampedValue - range.lowerBound) / (range.upperBound - range.lowerBound)
    }
}
