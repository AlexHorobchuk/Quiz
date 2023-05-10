//
//  EndOfQuizVM.swift
//  Quiz
//
//  Created by Olha Dzhyhirei on 5/8/23.
//

import SwiftUI

final class EndOfQuizVM: ObservableObject {
    
    var info: Info
    var result: Int
    var didWin: Bool
    var time: Double
    
    init(info: Info, result: Int, didWin: Bool, time: Double) {
        self.info = info
        self.result = result
        self.didWin = didWin
        self.time = time
    }
}
