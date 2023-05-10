//
//  LevelView.swift
//  Quiz
//
//  Created by Olha Dzhyhirei on 5/6/23.
//

import SwiftUI

struct LevelView: View {
    var level: Int
    var currentBest: Int
    var maxQuestion: Int
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Text("LEVEL \(level)")
                    
                    
                    Spacer()
                    
                    
                    Text("\(currentBest) - \(maxQuestion)")
                        .font(.system(size: 22, weight: .bold))
                        .opacity(0.5)
                }
                
                ProgressView(value: Double(currentBest), total: 10)
                .accentColor(.white)
            }
            
            Divider()
                .background(Color.white)
                .padding(.horizontal)
            
            Image(systemName: "chevron.right")
                .opacity(0.5)
        }
        .padding(.horizontal, 20)
        .font(.system(size: 22, weight: .bold))
        .foregroundColor(.white)
        .frame(height: 90)
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.1)))
    }
}

struct LevelView_Previews: PreviewProvider {
    static var previews: some View {
        LevelView(level: 1, currentBest: 3, maxQuestion: 10)
            .background(Color.black)
    }
}
