//
//  GameSetterVM.swift
//  Quiz
//
//  Created by Olha Dzhyhirei on 5/7/23.
//

import SwiftUI

final class GameSetterVM: ObservableObject {
    
    @Published var questions: [Question] = []
    @Published var alert: AlertItem?
    
    private var category: Category
    private var selectedLevel: Int?
    private var minAndMax = (1 , 5)
    
    init(category: Category) {
        self.category = category
    }
    
    // MARK: incease if we will have different amaount of question for levels
    func maxQuestion() -> Int {
        return 10
    }
    
    func createInfo() -> Info {
       return  Info(questions: questions,
                    maxQuestions: maxQuestion(),
                    level: selectedLevel ?? 1,
                    maxLevel: minAndMax.1,
                    category: category.name)
    }
    
    func selectLevel(_ level: Int) {
        selectedLevel = level
    }
    
    func setQuestions(for level: Int) -> [Question] {
        guard let hardnes = LevelHardnes(rawValue: level)?.getHardnes() else { return [] }
        let result = questions.filter( { hardnes.contains($0.difficulty.degree)  } )
        return result
    }
    
    func levelRange() -> ClosedRange<Int> {
        return minAndMax.0...minAndMax.1
    }
    
    func loadQuestions() {
        NetworkManager.shared.fetchQuestion(for: category._id) { [self] (result) in
            
            DispatchQueue.main.async {
                switch result {
                    
                case .success(let allQuestions):
                    self.questions = allQuestions.questions
                    
                case .failure(let error):
                    switch error {
                    case .invalidURL:
                        self.alert = AlertContext.invalidURL
                    case .invalidResponse:
                        self.alert = AlertContext.invalidResponse
                    case .invalidData:
                        self.alert = AlertContext.invalidData
                    case .unableToComplete:
                        self.alert = AlertContext.unableToComplete
                    }
                }
            }
        }
    }
    
    private enum LevelHardnes: Int {
        case superEase = 1, easy, medium, hard, superHard
        
        func getHardnes() -> [String] {
            switch self {
            case .superEase:
                return ["Easy"]
            case .easy:
                return ["Easy", "Medium"]
            case .medium:
                return ["Medium"]
            case .hard:
                return ["Hard", "Medium"]
            case .superHard:
                return ["Hard"]
            }
        }
    }
}
