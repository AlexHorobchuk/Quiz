//
//  File.swift
//  Quiz
//
//  Created by Olha Dzhyhirei on 5/10/23.
//

import SwiftUI

struct NextButton: View {
    
    var text: String
    
    var body: some View {
        HStack {
            
            Text(text)
                .padding(.leading, 20)
            
            Spacer()
            
            
            Image(systemName: "chevron.right")
                .opacity(0.5)
        }
        .padding(.horizontal, 20)
        .font(.system(size: 22, weight: .bold))
        .foregroundColor(.white)
        .frame(height: 60)
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.red))
    }
}
