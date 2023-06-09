//
//  QuizGame.swift
//  Quiz
//
//  Created by Olha Dzhyhirei on 5/6/23.
//

import SwiftUI

struct QuizGame: View {
    
    @EnvironmentObject var storage: StorageController
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var game: GameVM
    
    @State var timer: Timer?
    
    var body: some View {
        BaseView() {
            ZStack {
                VStack {
                    GameLevel(action: game.goBack,
                              level: game.info.level)
                    
                    GameProgress(time: game.timeDisplay.time(),
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
                        }
                            if game.gameFinished {
                            self.timer?.invalidate()
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
                    destination: EndOfQuiz(endGameVM: EndOfQuizVM(info: game.info,
                                                                  result: game.getResult(),
                                                                  didWin: game.didWin(),
                                                                  time: game.timeDisplay)),
                    isActive: $game.gameFinished) { EmptyView() }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                game.myTimer()
            }
        }
        .alert(item: $game.alert) { alert in
            Alert(title: alert.title,
                  message: alert.message,
                  primaryButton: .destructive(Text("Yes")) {
                                presentationMode.wrappedValue.dismiss()
                            },
                  secondaryButton: alert.dismissButton)
        }
        .onDisappear {
            self.timer?.invalidate()
            if game.gameFinished {
                storage.updateLevel(level: game.info.level,
                                    newTime: game.timeDisplay,
                                    result: game.getResult(),
                                    updateMax: game.needUpdateMax())
            }
        }
    }
}
