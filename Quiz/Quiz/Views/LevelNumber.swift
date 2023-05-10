//
//  LevelNumber.swift
//  Quiz
//
//  Created by Olha Dzhyhirei on 5/6/23.
//

import SwiftUI

struct LevelNumber: View {
    
    var level: Int
    
    var body: some View {
        HStack {
            Text("LEVEL")
                .foregroundColor(.white)
            Text("# \(level)")
                .foregroundColor(.red)
        }
        .font(.system(size: 22, weight: .bold))
    }
}

struct LevelNumber_Previews: PreviewProvider {
    static var previews: some View {
        LevelNumber(level: 1).background(Color.black)
    }
}
