//
//  GameProgress.swift
//  Quiz
//
//  Created by Olha Dzhyhirei on 5/6/23.
//

import SwiftUI

struct GameProgress: View {
    
    var time: String
    var questionNumber: Int
    var text: String
    
    var body: some View {
        HStack {
            Spacer()
            
            VStack {
                Text(text)
                    .font(.system(size: 20, weight: .bold))
                    .opacity(0.4)
                HStack {
                    Text("\(questionNumber)")
                        .foregroundColor(.red)
                    Text("- 10")
                }
                .font(.system(size: 24, weight: .bold))
            }
            .frame(maxWidth: .infinity)
            
            Divider()
                .background(Color.white)
                .opacity(0.5)
            
            VStack {
                Text("Time")
                    .font(.system(size: 20, weight: .bold))
                    .opacity(0.4)
                Text(time)
                    .font(.system(size: 24, weight: .bold))
            }
            .frame(maxWidth: .infinity)
        }
        .foregroundColor(.white)
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.1)))
        .frame(height: 80)
        .padding(10)
    }
}

struct GameProgress_Previews: PreviewProvider {
    static var previews: some View {
        GameProgress(time: "0.00", questionNumber: 3, text: "Questions").background(Color.black)
    }
}
