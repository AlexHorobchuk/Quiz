//
//  GameInfo.swift
//  Quiz
//
//  Created by Olha Dzhyhirei on 5/6/23.
//

import SwiftUI

struct GameInfo: View {
    
    @EnvironmentObject var storage: StorageController
    @StateObject var infoVM: GameInfoVM
    
    
    var body: some View {
        BaseView() {
            VStack {
                
                LevelNumber(level: infoVM.info.level)
                
                Spacer()
                
                ScaledImage(name: Getter.shared.categoryImage(category: infoVM.info.category), size: .init(width: 250, height: 250))
                    .opacity(0.2)
                
                Spacer()
                
                ProgressTable(averageTime: storage.getLevelsAvarageTime(level: 1) == 0.00 ?
                              "-:-" : String(format: "%.2f", storage.getLevelsAvarageTime(level: 1).convertToMinutesAndSeconds()))
                
                
                NavigationLink(destination: { QuizGame(game: GameVM(info: infoVM.info))
                .environmentObject(storage)
                }
                               , label: {
                    MainButton(text: "Single player")
                })
                .padding(10)
                
                NavigationLink(destination: { }, label: {
                    MainButton(text: "Multiplayer")
                })
                .padding(10)
                
                Spacer()
            }
            .padding(.horizontal)
        }
    }
}
