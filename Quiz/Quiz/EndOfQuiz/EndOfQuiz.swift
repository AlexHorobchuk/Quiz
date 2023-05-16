//
//  EndOfQuiz.swift
//  Quiz
//
//  Created by Olha Dzhyhirei on 5/7/23.
//

import SwiftUI

struct EndOfQuiz: View {
    
    @EnvironmentObject var navigation: NavigationHelper
    
    @StateObject var endGameVM: EndOfQuizVM
    
    @State private var isRotated = false
    
    var body: some View {
        BaseView() {
            ZStack {
                if endGameVM.didWin {
                    ParticleEffectView().shadow(color: .white, radius: 3)
                }
                
                VStack {
                    LevelNumber(level: endGameVM.info.level)
                    
                    Spacer()
                    
                    HStack {
                        ScaledImage(
                            name: endGameVM.didWin ? "trophy.fill" : "hand.thumbsdown.fill",
                            size: .init(width: 80, height: 80)
                        )
                        .opacity(0.5)
                        .rotationEffect(isRotated ? Angle(degrees: -15) : Angle(degrees: 15))
                        .onAppear {
                            withAnimation(Animation.easeInOut(duration: 1.0).repeatForever()) {
                                isRotated.toggle()
                            }
                        }
                        
                        Text(endGameVM.didWin ? "VICTORY" : "DEFEAT")
                            .foregroundColor(.white)
                            .font(.system(size: 32,weight: .heavy))
                            .minimumScaleFactor(0.5)
                        
                        ScaledImage(name: endGameVM.didWin ? "trophy.fill" : "hand.thumbsdown.fill",
                                    size: .init(width: 80, height: 80))
                        .opacity(0.5)
                        .rotationEffect(isRotated ?
                                          Angle(degrees: endGameVM.didWin ? 15 : -15)
                                        : Angle(degrees: endGameVM.didWin ? -15 : 15))
                        .scaleEffect(x: -1, y: 1)
                    }
                    
                    Spacer()
                    
                    GameProgress(time: endGameVM.time.time(),
                                 questionNumber: endGameVM.result, text: "Correct answers")
                    
                    Spacer()
                    
                    Button(
                        action: { navigation.showNextView = false },
                        label: { MainButton(text: "Menu") }
                    )
                    
                    Spacer()
                }
                .padding(.horizontal)
                .navigationBarBackButtonHidden(true)
            }
        }
    }
}

