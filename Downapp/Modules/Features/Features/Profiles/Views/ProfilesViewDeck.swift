//
//  ProfileDeck.swift
//  Features
//
//  Created by Alexey Zhemblouski on 25/10/2025.
//

import SwiftUI
import UI

struct ProfilesDeck: View {
    @Binding private(set) var decisionSync: ProfilesDecision?
    
    init(decisionSync: Binding<ProfilesDecision?>) {
        self._decisionSync = decisionSync
    }
    
    var body: some View {
        HStack(spacing: 60) {
            ForEach([
                ProfilesDecision.positive,
                ProfilesDecision.negative
            ], id: \.self) { dec in
                IconActionButtonView(
                    icon: dec.icon,
                    text: dec.text,
                    accentColor: dec.color,
                    onTap: {
                        if decisionSync == nil {
                            decisionSync = dec
                        }
                    }
                )
            }
        }
    }
}

#if DEBUG
#Preview {
    @Previewable @State var decisionSync: ProfilesDecision?
    
    Color.yellow
        .overlay {
            ProfilesDeck(decisionSync: $decisionSync)
        }
}
#endif
