//
//  ToastView.swift
//  UI
//
//  Created by Alexey Zhemblouski on 25/10/2025.
//

import SwiftUI

public struct ToastView: View {
    private enum Constants {
        static let toastHeight: CGFloat = 100.0
    }
    
    private let icon: Image
    private let text: String
    private let accentColor: Color
    
    public init(icon: Image, text: String, accentColor: Color) {
        self.icon = icon
        self.text = text
        self.accentColor = accentColor
    }

    public var body: some View {
        HStack {
            icon
                .resizable()
                .aspectRatio(1.0, contentMode: .fit)
                .foregroundStyle(accentColor)
            
            Text(text.uppercased())
                .font(.largeTitle.bold())
                .foregroundStyle(.white)
        }
        .padding(32)
        .background(.white.opacity(0.3))
        .frame(height: Constants.toastHeight)
        .cornerRadius(Constants.toastHeight * 0.5)
    }
}

#if DEBUG
#Preview {
    Color.yellow
        .overlay {
            ToastView(
                icon: Image(systemName: "heart.fill"),
                text: "Date",
                accentColor: .blue
            )
        }
}
#endif
