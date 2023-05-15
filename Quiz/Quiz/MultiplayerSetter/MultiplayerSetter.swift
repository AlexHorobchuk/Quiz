//
//  SwiftUIView.swift
//  Quiz
//
//  Created by Olha Dzhyhirei on 5/10/23.
//

import SwiftUI

struct MultiplayerSetter: View {
    
    @StateObject var multiplayerSetter: MultiplayerSetterVM
    
    var body: some View {
        BaseView() {
            VStack {
                Spacer()
                
                Button (
                    action: {
                        multiplayerSetter.createGame()
                    },
                    label: { MainButton(text: "Create") }
                )
                .padding(10)
                
                Button (
                    action: {
                        multiplayerSetter.jointToTheGame()
                    },
                    label: { MainButton(text: "Join") }
                )
                .padding(10)
                
                NavigationLink(
                    destination: {},
                    label: { MainButton(text: "Statistics") }
                )
                .padding(10)
                
                NavigationLink(
                    destination: MultiplayerGame(multiplayer: multiplayerSetter,
                                                 game: multiplayerSetter.game),
                    isActive: $multiplayerSetter.connected) { EmptyView() }
                
                Spacer()
            }
            .padding(.horizontal)
        }
    }
}
