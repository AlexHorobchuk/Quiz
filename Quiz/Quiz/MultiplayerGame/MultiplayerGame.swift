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
    
    @State var timer: Timer?
    
    var body: some View {
        BaseView() {
            ZStack {
                VStack {
                    GameLevel(action: multiplayer.goBack,
                              level: multiplayer.game.info.level)
                    
                    GameProgress(time: multiplayer.game.timeDisplay.time(),
                                 questionNumber: multiplayer.game.index + 1, text: "Questions")
                    
                    ForEach(multiplayer.game.info.questions, id: \.self._id) { question in
                        if multiplayer.game.currentQuestion() == question {
                            ScrollView {
                                QuestionText(text: question.text)
                                
                                Spacer()
                            }
                            
                            ForEach(Array(question.options.enumerated()), id: \.element) { index, value  in
                                AnswerButton(
                                    action: {
                                        withAnimation(.easeInOut(duration: 0.5)) {
                                            multiplayer.game.selectQuestion(number: index)
                                        }
                                    },
                                    selected: $multiplayer.game.selected,
                                    isRight: $multiplayer.game.answerdRight,
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
                            multiplayer.game.confirmAnswer()
                            if multiplayer.game.gameFinished {
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
                    isActive: $multiplayer.game.gameFinished) { EmptyView() }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                multiplayer.game.myTimer()
                multiplayer.sendRemainingTime()
            }
        }
        .onChange(of: multiplayer.game.gameFinished) { newValue in
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
