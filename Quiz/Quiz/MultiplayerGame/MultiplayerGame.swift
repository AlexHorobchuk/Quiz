//
//  MultiplayerGame.swift
//  Quiz
//
//  Created by Olha Dzhyhirei on 5/13/23.
//

import SwiftUI

struct MultiplayerGame: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var multiplayer: MultiplayerSetterVM
    @ObservedObject var game: MultilPlayerGameVM
    
    @State var timer: Timer?
    
    var body: some View {
        BaseView() {
            ZStack {
                VStack {
                    GameLevel(action: multiplayer.goBack,
                              level: game.info.level)
                    
                    GameProgress(time: multiplayer.game.timeDisplay.time(),
                                 questionNumber: game.index + 1, text: "Questions")
                    
                    ForEach(game.info.questions, id: \.self._id) { question in
                        if game.currentQuestion() == question {
                            ScrollView {
                                QuestionText(text: question.text)
                                
                                Spacer()
                            }
                            
                            ForEach(Array(question.options.enumerated()), id: \.element) { index, value  in
                                AnswerButton(
                                    action: {
                                        withAnimation(.easeInOut(duration: 0.5)) {
                                            game.selectQuestion(number: index)
                                        }
                                    },
                                    selected: $game.selected,
                                    isRight: $game.answerdRight,
                                    text: value.option,
                                    index: index)
                                .padding(10)
                            }
                        }
                    }
                    .transition(.asymmetric(insertion: .move(edge: .leading),
                                            removal: .move(edge: .trailing)))
                    
                    Button(
                        action: { withAnimation(.easeInOut(duration: 1)) {
                            game.confirmAnswer()
                            if game.gameFinished {
                                self.timer?.invalidate()
                            }
                        }
                        },
                        label: {
                            NextButton(text: "Next")
                        })
                    .padding(.bottom, 30)
                    .padding(10)
                    
                }
                .padding(.horizontal)
                
                NavigationLink(
                    destination: EndOfMultiplayer(game: multiplayer),
                    isActive: $game.gameFinished) { EmptyView() }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                game.myTimer()
                multiplayer.sendRemainingTime()
            }
        }
        .onChange(of: game.gameFinished) { newValue in
            if newValue {
                multiplayer.sendResult()
            }
        }
        .alert(item: $multiplayer.alert) { alert in
            Alert(title: alert.title,
                  message: alert.message,
                  primaryButton: .destructive(Text("Yes")) {
                multiplayer.surrender()
                presentationMode.wrappedValue.dismiss()
            },
                  secondaryButton: alert.dismissButton)
        }
        .onDisappear {
            self.timer?.invalidate()
        }
    }
}
