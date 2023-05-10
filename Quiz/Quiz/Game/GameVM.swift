//
//  GameVM.swift
//  Quiz
//
//  Created by Olha Dzhyhirei on 5/8/23.
//

import SwiftUI

final class GameVM: ObservableObject {
    
    @Published var index = 0
    @Published var selected: Int?
    @Published var timeDisplay: Double = 0
    @Published var gameFinished = false
    @Published var answerdRight: Bool?
    
    private var answers : [Bool] = []
    
    var info : Info
    
    init(info: Info) {
        self.info = info
        setupGame()
    }
    
    func myTimer() {
        if !gameFinished {
            timeDisplay += 1
        }
    }
    
    func currentQuestion() -> Question {
        return info.questions[index]
    }
    
    func setupGame() {
        info.questions = Array(info.questions.shuffled().prefix(10))
    }
    
    func didWin() -> Bool {
        return answers.filter({ $0 == true }).count >= 8
    }
    
    func needUpdateMax() -> Bool {
        if didWin() && info.maxLevel > info.level {
            return true
        }
        return false
    }
    
    func getResult() -> Int {
        return answers.filter({ $0 == true }).count
    }
    
    func confirmAnswer() {
        if selected != nil && !gameFinished {
            let answer = info.questions[index].options[selected!].isCorrect
            answers.append(answer)
            answerdRight = answer
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.answerdRight = nil
                self.selected = nil
                self.isGameFinished()
            }
        }
    }
    
    func isGameFinished() {
        guard index+1 != info.maxQuestions else { return gameFinished = true }
        index += 1
    }
    
    func selectQuestion(number: Int) {
        if !gameFinished {
            selected = number
        }
    }
}
