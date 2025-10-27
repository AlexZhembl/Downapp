//
//  ProfilesViewCard.swift
//  Features
//
//  Created by Alexey Zhemblouski on 25/10/2025.
//

import Core
import SwiftUI
import UI

struct ProfilesViewCard: View {
    private enum Constants {
        static let maxOffset: Double = 70.0
        static let decisionDelay: Double = 0.5
    }
    
    @Binding private(set) var decisionSync: ProfilesDecision?
    @State private var dragOffset: CGSize = .zero
    
    private let profile: Profile
    private let onFinalDecision: (ProfilesDecision) -> Void
    
    init(
        decisionSync: Binding<ProfilesDecision?>,
        profile: Profile,
        onFinalDecision: @escaping (ProfilesDecision) -> Void
    ) {
        self._decisionSync = decisionSync
        self.profile = profile
        self.onFinalDecision = onFinalDecision
    }
    
    var body: some View {
        DragFeedbackView(
            dragOffset: $dragOffset,
            maxOffset: Constants.maxOffset,
            topColor: ProfilesDecision.negative.color,
            bottomColor: ProfilesDecision.positive.color
        ) {
            Color.clear
                // Used to render `AsyncImage` as an overlay
                .contentShape(Rectangle())
                .overlay {
                    UrlImage(url: profile.profilePictureURL)
                }
                .overlay {
                    ZStack {
                        if dragOffset.height == 0 {
                            infoView()
                        } else {
                            toastView()
                        }
                    }
                    .animation(.none, value: dragOffset)
                }
        }
        .onChange(of: decisionSync) {
            withAnimation(.linear(duration: Constants.decisionDelay)) {
                checkOffset()
            }
        }
        .onChange(of: dragOffset) {
           checkDecision()
        }
    }
    
    private func checkOffset() {
        if decisionSync == .negative {
            dragOffset.height = Constants.maxOffset
        } else if decisionSync == .positive {
            dragOffset.height = -Constants.maxOffset
        }
    }
    
    private func checkDecision() {
        let finalDecision: ProfilesDecision?
        if dragOffset.height >= Constants.maxOffset {
            finalDecision = .negative
        } else if dragOffset.height <= -Constants.maxOffset {
            finalDecision = .positive
        } else {
            finalDecision = nil
        }
        
        finalDecision.flatMap { dec in
            DispatchQueue.delay(Constants.decisionDelay) {
                decisionSync = nil
                onFinalDecision(dec)
            }
        }
    }
    
    @ViewBuilder
    private func toastView() -> some View {
        let decision: ProfilesDecision =
            dragOffset.height > 0 ? .negative : .positive

        ToastView(
            icon: decision.icon,
            text: decision.text,
            accentColor: decision.color
        )
    }
    
    @ViewBuilder
    private func infoView() -> some View {
        VStack {
            Spacer()
            
            Text("\(profile.name), \(profile.age)")
                .font(.largeTitle.bold())
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(profile.location)
                .font(.caption)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 40)
        .background {
            LinearGradient(
                colors: [.black, .clear],
                startPoint: .bottom,
                endPoint: .center
            )
        }
    }
}

#if DEBUG
#Preview {
    @Previewable @State var decisionSync: ProfilesDecision?
    
    ProfilesViewCard(
        decisionSync: $decisionSync,
        profile: .mock(id: 123),
        onFinalDecision: { _ in
            decisionSync = nil
        }
    )
}
#endif
