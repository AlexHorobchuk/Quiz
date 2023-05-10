//
//  GameSetter.swift
//  Quiz
//
//  Created by Olha Dzhyhirei on 5/5/23.
//

import SwiftUI

struct GameSetter: View {
    
    @StateObject var storage: StorageController
    @StateObject var gameSetterVM: GameSetterVM
    @State var showNext = false
    
    var body: some View {
        BaseView() {
            Group {
                if gameSetterVM.questions.isEmpty {
                    
                    LoadingView()
                }
                
                else {
                    
                    VStack {
                        
                        ForEach(gameSetterVM.levelRange() , id: \.self) { level in
                            
                            if level <= storage.openLevel {
                                Button(action: {
                                    gameSetterVM.selectLevel(level)
                                    showNext = true
                                } ,
                                       label: {
                                    LevelView(level: level,
                                              currentBest: storage.getLevelsBestResult(level: level),
                                              maxQuestion: gameSetterVM.maxQuestion())
                                })}
                            else {
                                LevelView(level: level, currentBest: 0, maxQuestion: gameSetterVM.maxQuestion())
                                    .opacity(0.5)
                            }
                        }
                        
                        NavigationLink(destination: GameInfo(infoVM: GameInfoVM(info: gameSetterVM.createInfo()))
                            .environmentObject(storage),
                                       isActive: $showNext) { EmptyView() }
                        
                        Spacer()
                    }
                    
                    .padding(.top, 50)
                    .padding(.horizontal, 20)
                }
            }
            .alert(item: $gameSetterVM.alert) { alert in
                Alert(title: alert.title, message: alert.message, dismissButton: alert.dismissButton)
            }
        }
        .onAppear(perform: {
            gameSetterVM.loadQuestions()
        })
    }
}

struct GameSetter_Previews: PreviewProvider {
    static var previews: some View {
        GameSetter(storage: StorageController(category: "Sport"), gameSetterVM: GameSetterVM(category: Category(_id: "1", name: "Sport")))
    }
}
