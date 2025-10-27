//
//  UI.swift
//  UI
//
//  Created by Alexey Zhemblouski on 25/10/2025.
//

import Core
import SwiftUI

private enum DragFeedbackViewConstants {
    static let cornerRadius = 40.0
}

public struct DragFeedbackView<Content: View>: View {
    
    @Binding private(set) var dragOffset: CGSize
    
    private let maxOffset: Double
    private let topColor: Color
    private let bottomColor: Color
    private let content: () -> Content
    
    public init(
        dragOffset: Binding<CGSize>,
        maxOffset: Double,
        topColor: Color,
        bottomColor: Color,
        content: @escaping () -> Content
    ) {
        self._dragOffset = dragOffset
        self.maxOffset = maxOffset
        self.topColor = topColor
        self.bottomColor = bottomColor
        self.content = content
    }
    
    public var body: some View {
        content()
            .overlay {
                gradient()
            }
            .cornerRadius(DragFeedbackViewConstants.cornerRadius)
            .offset(dragOffset)
            .simultaneousGesture(
                // `minimumDistance` used to avoid drag conflicts
                DragGesture(minimumDistance: 17)
                    .onChanged { gesture in
                        guard abs(dragOffset.height) != maxOffset else {
                            return
                        }
                        
                        let clamped = gesture.translation.height.clamped(
                            to: -maxOffset...maxOffset
                        )
                        
                        dragOffset = .init(width: 0, height: clamped)
                    }
                    .onEnded { _ in
                        if abs(dragOffset.height) != maxOffset {
                            dragOffset = .zero
                        }
                    }
            )
    }
    
    @ViewBuilder
    private func gradient() -> some View {
        let yOffset = dragOffset.height
        
        let topOpacity = max(0, yOffset)
            .normalized(from: 0...100)
        let bottomOpacity = max(0, -yOffset)
            .normalized(from: 0...100)

        LinearGradient(
            colors: [
                topColor.opacity(topOpacity),
                bottomColor.opacity(bottomOpacity)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

#if DEBUG
#Preview {
    @Previewable @State var dragOffset: CGSize = .zero
    
    Color.yellow.overlay {
        DragFeedbackView(
            dragOffset: $dragOffset,
            maxOffset: 150,
            topColor: .red,
            bottomColor: .blue
        ) {
            Image(systemName: "heart.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(.blue)
                .padding()
        }
        .onChange(of: dragOffset) {
            if abs(dragOffset.height) == 150 {
                dragOffset = .zero
            }
        }
    }
}
#endif
