//
//  StatisticResult.swift
//  Quiz
//
//  Created by Olha Dzhyhirei on 5/15/23.
//

import SwiftUI

struct StatisticResult: View {
    
    var result: MPResult
    
    var body: some View {
        HStack {
            HStack{
                Text("\(Int(result.myResult))")
                    .foregroundColor(.red)
                
                Text("- 10")
                    .foregroundColor(.white)
            }
            .frame(width: 75)
            .font(.system(size: 24, weight: .semibold))
            
        Divider()
            .background(Color.white)
            .opacity(0.5)
            
            ScaledImage(name: result.didWin ?
                        "trophy.fill" : "hand.thumbsdown.fill",
                        size: .init(width: 25, height: 25))
                .padding(.horizontal, 10)
            
            Divider()
                .background(Color.white)
                .opacity(0.5)
            
            HStack{
                Text("\(Int(result.enemyResult))")
                    .foregroundColor(.red)
                
                Text("- 10")
                    .foregroundColor(.white)
                
            }
            .frame(width: 75)
            .font(.system(size: 24, weight: .semibold))
            
            Divider()
                .background(Color.white)
                .opacity(0.5)
            
            Text(result.enemyName!)
                .lineLimit(1)
                .foregroundColor(.white)
                .font(.system(size: 22, weight: .bold))
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
            
            
        }
        .opacity(0.9)
        .frame(maxWidth: .infinity)
        .frame(height: 60)
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.1)))
    }
}
