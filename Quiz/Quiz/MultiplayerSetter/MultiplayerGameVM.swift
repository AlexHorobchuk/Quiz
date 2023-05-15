//
//  MultiplayerGame.swift
//  Quiz
//
//  Created by Olha Dzhyhirei on 5/13/23.
//

import SwiftUI

final class MultilPlayerGameVM: GameVM {
    
    override init(info: Info) {
        super.init(info: info)
        timeDisplay = 120
    }
    
    override func myTimer() {
        if timeDisplay == 0 {
            gameFinished = true
        } else if !gameFinished {
            timeDisplay -= 1
        }
    }
}
