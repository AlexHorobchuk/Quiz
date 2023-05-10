//
//  GameInfoVM.swift
//  Quiz
//
//  Created by Olha Dzhyhirei on 5/8/23.
//

import SwiftUI

final class GameInfoVM: ObservableObject {
    
    var info: Info
    
    init(info: Info) {
        self.info = info
    }
}
