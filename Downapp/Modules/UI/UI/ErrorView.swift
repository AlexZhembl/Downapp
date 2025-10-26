//
//  ErroVie.swift
//  UI
//
//  Created by Alexey Zhemblouski on 25/10/2025.
//

import SwiftUI

public struct ErrorView: View {
    let message: String
    let buttonText: String
    let retryAction: (() -> Void)?
    
    public init(
        message: String,
        buttonText: String,
        retryAction: (() -> Void)?
    ) {
        self.message = message
        self.buttonText = buttonText
        self.retryAction = retryAction
    }

    public var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "xmark.circle.fill")
                .font(.system(size: 50))
                .foregroundColor(.red)

            Text(message)
                .font(.headline)
                .foregroundColor(.white)

            if let retryAction {
                Button(action: retryAction) {
                    Text(buttonText)
                        .fontWeight(.medium)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 10)
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(10)
                }
                .foregroundColor(.white)
            }
        }
        .padding()
    }
}

#if DEBUG
#Preview {
    Color.yellow.overlay {
        ErrorView(
            message: "Some error happened",
            buttonText: "Try again",
            retryAction: {}
        )
    }
}
#endif
