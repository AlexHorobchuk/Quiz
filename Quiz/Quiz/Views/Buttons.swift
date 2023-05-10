//
//  CategoryButton.swift
//  Quiz
//
//  Created by Olha Dzhyhirei on 5/5/23.
//

import SwiftUI

struct MainButton: View {
    
    var text: String
    
    
    var body: some View {
        HStack {
            Image(systemName: Getter.shared.categoryImage(category: text))
                .opacity(0.5)
                .imageScale(.large)
                .frame(width: 60, height: 60)
            
            
            Text(text)
            
            
            Spacer()
            
            
            Image(systemName: "chevron.right")
                .opacity(0.5)
        }
        .padding(.horizontal, 20)
        .font(.system(size: 24, weight: .bold))
        .foregroundColor(.white)
        .frame(height: 60)
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.1)))
    }
}

struct NextButton: View {
    
    var text: String
    
    
    var body: some View {
        HStack {
            Image(systemName: Getter.shared.categoryImage(category: text))
                .opacity(0.5)
                .imageScale(.large)
                .frame(width: 60, height: 60)
            
            
            Text(text)
            
            
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

struct AnswerButton: View {
    
    var text: String
    
    
    var body: some View {
        Text(text)
            //.foregroundColor(.white)
            .font(.system(size: 22, weight: .semibold))
            .multilineTextAlignment(.center)
            .frame(height: 60)
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.1)))
    }
}

