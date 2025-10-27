//
//  Features.swift
//  Features
//
//  Created by Alexey Zhemblouski on 25/10/2025.
//

import Core
import SwiftUI
import UI

struct ProfilesView: View {
    private enum Constants {
        static let outOfProfilesMessage = "We are out of profiles 😜"
        static let outOfProfilesButtonText = "Reset them!"
        static let errorMessage = "Oops. somthing went wrong with network"
        static let errorButtonText = "Try again"
        static let navigationTitle = "Profiles"
    }
    
    @ObservedObject var viewModel: ProfilesViewModel
    @State private var currentProfileIdx: Int = 0
    @State private var decisionSync: ProfilesDecision?
    
    var body: some View {
        Color.black
            .overlay {
                switch viewModel.state {
                case let .loaded(profiles):
                    cardsView(profiles: profiles)
                    
                case .idle, .loading:
                    SpinnerView()
                    
                case .outOfProfiles:
                    ErrorView(
                        message: Constants.outOfProfilesMessage,
                        buttonText: Constants.outOfProfilesButtonText
                    ) {
                        viewModel.resetProfiles()
                    }
                    
                case .failed:
                    ErrorView(
                        message: Constants.errorMessage,
                        buttonText: Constants.errorButtonText
                    ) {
                        viewModel.retryLoading()
                    }
                }
            }
            .ignoresSafeArea()
            .onAppear(perform: viewModel.viewDidAppear)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .navigationTitle(Constants.navigationTitle)
    }
    
    @ViewBuilder
    private func cardsView(profiles: [Profile]) -> some View {
        ZStack {
            TabView(selection: $currentProfileIdx) {
                ForEach(profiles.enumerated(), id: \.element.id) { idx, profile in
                    VStack {
                        ProfilesViewCard(
                            decisionSync: $decisionSync,
                            profile: profile
                        ) { finalDecision in
                            viewModel.decisionReceived(
                                finalDecision,
                                for: idx
                            )
                        }
                        
                        Spacer(minLength: 100)
                    }
                    .tag(idx)
                }
                .padding(.horizontal, 4)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .ignoresSafeArea()

            VStack {
                Spacer()
        
                ProfilesDeck(decisionSync: $decisionSync)
            }
            .frame(maxWidth: .infinity)
        }
        .background(.black)
    }
}

#if DEBUG
#Preview {
    ProfilesView(viewModel: .init(
        fetcher: ProfilesFetcherMock(),
        decisionStorage: ProfilesDecisionStorageMock()
    ))
}
#endif
