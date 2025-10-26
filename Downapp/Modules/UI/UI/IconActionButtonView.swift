//
//  IconButtonView.swift
//  UI
//
//  Created by Alexey Zhemblouski on 25/10/2025.
//

import SwiftUI

public struct IconActionButtonView: View {
    private enum Constants {
        static let iconSize: CGFloat = 30
    }
    
    private let icon: Image
    private let text: String
    private let accentColor: Color
    private let onTap: () -> Void
    
    public init(icon: Image, text: String, accentColor: Color, onTap: @escaping () -> Void) {
        self.icon = icon
        self.text = text
        self.accentColor = accentColor
        self.onTap = onTap
    }
    
    public var body: some View {
        Button(action: onTap) {
            VStack {
                icon
                    .resizable()
                    .aspectRatio(1.0, contentMode: .fit)
                    .foregroundStyle(accentColor)
                    .frame(
                        width: Constants.iconSize,
                        height: Constants.iconSize
                    )
                    .padding(Constants.iconSize)
                    .background(.white)
                    .cornerRadius(Constants.iconSize * 2)
                    .overlay {
                        Circle()
                            .stroke(.gray, lineWidth: 2)
                    }
                
                Text(text.uppercased())
                    .font(.default.bold())
                    .foregroundStyle(.white)
            }
        }
    }
}

#if DEBUG
#Preview {
    Color.yellow.overlay {
        IconActionButtonView(
            icon: Image(systemName: "heart.fill"),
            text: "Date",
            accentColor: .blue
        ) { }
    }
}
#endif
