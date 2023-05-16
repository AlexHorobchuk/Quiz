//
//  MPPlayerResults.swift
//  Quiz
//
//  Created by Olha Dzhyhirei on 5/14/23.
//

import SwiftUI

struct MPPlayerResults: View {
    
    var result: MultiplayerResult
    
    var body: some View {
        VStack {
            Text(result.name)
                .foregroundColor(.white)
                .font(.system(size: 22, weight: .bold))
                .opacity(0.4)
                .padding(20)
                .lineLimit(1)
            
            Divider()
                .background(Color.white)
                .opacity(0.5)
            
            VStack {
                Text("Correct answers:")
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .semibold))
                    .opacity(0.4)
                
                HStack {
                    Text("\(result.result)")
                        .foregroundColor(.red)
                    
                    Text("- 10")
                        .foregroundColor(.white)
                }
                .padding(2)
                    .font(.system(size: 24, weight: .bold))
                
                Divider()
                    .background(Color.white)
                    .opacity(0.5)
                
            }
            .frame(height: 100)
            .frame(maxWidth: .infinity)
            
            VStack {
                Text("Time:")
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .semibold))
                    .opacity(0.4)
                    .padding(2)
                
                Text("\(result.time.time())")
                    .foregroundColor(.white)
                    .font(.system(size: 24, weight: .bold))
                    .padding(.bottom)
            }
            .frame(height: 80)
            
        }
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.1)))
    }
}
