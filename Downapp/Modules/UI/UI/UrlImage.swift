//
//  UrlImage.swift
//  UI
//
//  Created by Alexey Zhemblouski on 25/10/2025.
//

import SwiftUI

public struct UrlImage: View {
    private let url: URL

    @State private var isLoaded = false

    public init(url: URL) {
        self.url = url
    }

    public var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                SpinnerView()

            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .onAppear {
                        withAnimation(.easeInOut(duration: 0.25)) {
                            isLoaded = true
                        }
                    }
                    .opacity(isLoaded ? 1 : 0)
                    .transition(.opacity)

            case .failure:
                ZStack {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.white.opacity(0.5))
                        .padding()
                }

            @unknown default:
                EmptyView()
            }
        }
    }
}

#if DEBUG
#Preview {
    Color.yellow.overlay {
        UrlImage(
            url: URL(string: "https://down-static.s3.us-west-2.amazonaws.com/picks_filter/female_v2/pic00000.jp")!
        )
    }
}
#endif
