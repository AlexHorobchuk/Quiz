//
//  Model.swift
//  Quiz
//
//  Created by Olha Dzhyhirei on 5/2/23.
//

import Foundation


struct CategoryQuestions: Decodable {
    
    var questions: [Question]
    
}

struct Info {
    
    var questions: [Question]
    var maxQuestions: Int
    var level: Int
    let maxLevel: Int
    var category: String
    
}

struct Difficulty: Decodable {
    
    var _id: String
    var degree: String
    
}

struct Category: Decodable {
    
    var _id: String
    var name: String
    
}

struct Categories: Decodable {
    
    var categories: [Category]
    
}

struct Answer: Decodable, Hashable {
    
    var option: String
    var isCorrect: Bool
    
}

struct Question: Decodable {
    
    var _id: String
    var text: String
    var options: [Answer]
    var category: Category
    var difficulty: Difficulty
    
}

struct MultiplayerResult {
    
    var name: String
    var gaveUp: Bool
    var result: Int
    var time: Double
}
