//
//  QuizGame.swift
//  Quiz
//
//  Created by Olha Dzhyhirei on 5/6/23.
//

import SwiftUI

struct QuizGame: View {
    
    
    @EnvironmentObject var storage: StorageController
    @StateObject var game: GameVM
    @State var timer: Timer?
    
    func getShadowColor(index: Int) -> Color {
        if game.answerdRight == nil && index == game.selected {
            return Color.white
        } else if game.answerdRight != nil && index == game.selected {
            return game.answerdRight! ? Color.green : Color.red
        } else {
            return Color.clear
        }
    }
    
    func getTextColor(index: Int) -> Color {
        if game.answerdRight == nil {
            return Color.white
        } else if game.answerdRight == false && index == game.selected {
            return Color.red
        } else if game.answerdRight == true && index == game.selected {
            return Color.green
        } else {
            return Color.white
        }
    }
    
    var body: some View {
        BaseView() {
            ZStack {
                VStack {
                    
                    LevelNumber(level: game.info.level)
                    
                    GameProgress(time: String(format: "%.2f", game.timeDisplay.convertToMinutesAndSeconds()),
                                 questionNumber: game.index + 1, text: "Questions")
                    
                    ForEach(game.info.questions, id: \.self._id) { question in
                        
                        if game.currentQuestion() == question {
                            ScrollView {
                                QuestionText(text: question.text)
                                
                                Spacer()
                            }
                            
                            ForEach(Array(question.options.enumerated()), id: \.element) { index, value  in
                                Button(action: { withAnimation(.easeInOut(duration: 0.5)) {
                                    game.selectQuestion(number: index) }
                                }, label: {
                                    AnswerButton(text: value.option )
                                        .foregroundColor(getTextColor(index: index))
                                            .shadow(
                                                color: getShadowColor(index: index),
                                                radius: index == game.selected ? (game.answerdRight == nil ? 5 : 7) : 0
                                            )
                                })
                                .padding(10)
                            }
                        }
                    }
                    .transition(.asymmetric(insertion: .move(edge: .leading),
                                            removal: .move(edge: .trailing)))
                    
                    Button(action: { withAnimation(.easeInOut(duration: 0.5)) {
                        game.confirmAnswer()
                        if game.gameFinished {
                            self.timer?.invalidate()
                            
                            storage.updateLevel(level: game.info.level,
                                                newTime: game.timeDisplay,
                                                result: game.getResult(),
                                                updateMax: game.needUpdateMax())
                        }
                    }
                    }, label: {
                        NextButton(text: "Next")
                    })
                    .padding(.bottom, 30)
                    .padding(10)
                    
                }
                .padding(.horizontal)
                
                NavigationLink(destination: EndOfQuiz(endGameVM: EndOfQuizVM(info: game.info,
                                                                             result: game.getResult(),
                                                                             didWin: game.didWin(),
                                                                             time: game.timeDisplay)),
                               isActive: $game.gameFinished) { EmptyView() }
            }
        }
        .onAppear {
            self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                game.myTimer()
            }
        }
        .onDisappear {
            self.timer?.invalidate()
        }
    }
}
