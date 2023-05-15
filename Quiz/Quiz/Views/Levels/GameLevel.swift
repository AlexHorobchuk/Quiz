//
//  GameLevel.swift
//  Quiz
//
//  Created by Olha Dzhyhirei on 5/13/23.
//

import SwiftUI

struct GameLevel: View {
    
    var action: (()->())?
    var level: Int
    
    var body: some View {
        ZStack {
            LevelNumber(level: level)
            
            HStack {
                Button(action: { action?() },
                       label: {
                    Image(systemName: "x.circle")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.white)
                        .frame(width: 30 , height: 30)
                })
                .padding(.leading, 10)
                
                Spacer()
            }
        }
    }
}

struct GameLevel_Previews: PreviewProvider {
    static var previews: some View {
        GameLevel(level: 1).background(Color.black)
    }
}
