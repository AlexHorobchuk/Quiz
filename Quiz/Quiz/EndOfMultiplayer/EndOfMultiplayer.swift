//
//  EndOfMultiplayer.swift
//  Quiz
//
//  Created by Olha Dzhyhirei on 5/13/23.
//

import SwiftUI

struct EndOfMultiplayer: View {
    
    @EnvironmentObject var navigation: NavigationHelper
    
    @ObservedObject var game: MultiplayerSetterVM
    
    @State private var isRotated = false
    
    var body: some View {
        BaseView() {
            VStack {
                Spacer()
                
                if game.enemyResult == nil {
                    LoadingView(text: game.remainingTime.time())
                        .foregroundColor(.white)
                        .lineLimit(2)
                        .multilineTextAlignment(.center)
                }
                else {
                    HStack {
                        ScaledImage(
                            name: game.didWin() ?? true ? "trophy.fill" : "hand.thumbsdown.fill",
                            size: .init(width: 70, height: 70)
                        )
                        .opacity(0.5)
                        .rotationEffect(isRotated ? Angle(degrees: -15) : Angle(degrees: 15))
                       
                        VStack {
                            Text("YOU")
                                .foregroundColor(.red)
                                .font(.system(size: 34, weight: .bold))
                                .padding(.vertical)
                            
                            Text(game.didWin() ?? true ? "WIN" : "LOOSE")
                                .foregroundColor(.white)
                                .font(.system(size: 34, weight: .bold))
                        }
                        .offset(y: -50)
                        .padding()
                        
                        ScaledImage(name: game.didWin() ?? true ? "trophy.fill" : "hand.thumbsdown.fill",
                                    size: .init(width: 70, height: 70))
                        .opacity(0.5)
                        .rotationEffect(isRotated ?
                                          Angle(degrees: game.didWin() ?? true ? 15 : -15)
                                        : Angle(degrees: game.didWin() ?? true ? -15 : 15))
                        .scaleEffect(x: -1, y: 1)
                        .onAppear {
                            withAnimation(Animation.easeInOut(duration: 1.0).repeatForever()) {
                                isRotated.toggle()
                            }
                        }
                    }
                    .padding(.bottom, 10)
                    
                    HStack {
                        MPPlayerResults(result: game.createResult())
                            .padding(5)
                        
                        MPPlayerResults(result: game.enemyResult!)
                            .padding(5)
                    }
                    
                    Spacer()
                    
                    Button(
                        action: { navigation.showNextView = false },
                        label: { MainButton(text: "Menu") }
                    )
                    .padding(5)
                    .padding(.bottom, 40)
                }
                
                Spacer()
            }
            .onDisappear {
                game.saveResult()
                game.restart()
            }
            .padding(.horizontal)
            .navigationBarBackButtonHidden(true)
        }
    }
}
