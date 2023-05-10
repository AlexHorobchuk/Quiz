//
//  Extensions.swift
//  Quiz
//
//  Created by Olha Dzhyhirei on 5/5/23.
//

import SwiftUI


extension Question: Equatable {
    static func == (lhs: Question, rhs: Question) -> Bool {
        lhs._id == rhs._id
    }
}

extension Double {
    func convertToMinutesAndSeconds() -> Double {
        let minutes = Int(self) / 60
        let seconds = Int(self) % 60
        return Double(minutes) + Double(seconds) / 100
    }
}



