//
//  SpinnerView.swift
//  UI
//
//  Created by Alexey Zhemblouski on 25/10/2025.
//

import SwiftUI

public struct SpinnerView: View {
    private enum Constants {
        static let size: CGFloat = 100
    }
    
    @State private var phase = 0.0
    
    public init() {}
    
    public var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<3) { idx in
                Circle()
                    .fill(Color.white)
                    .frame(width: 8, height: 8)
                    .scaleEffect(phase == Double(idx) ? 1.2 : 0.8)
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 0.4).repeatForever(autoreverses: true)) {
                phase = 1
            }
        }
    }
}

#if DEBUG
#Preview {
    Color.yellow.overlay {
        SpinnerView()
    }
    .ignoresSafeArea()
}
#endif
