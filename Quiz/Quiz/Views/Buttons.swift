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
    var action: (()->())?
    var text: String
    var index: Int
    @Binding var selected: Int?
    @Binding var isRight: Bool?
    
    func getShadowColor(index: Int) -> Color {
        if isRight == nil && index == selected {
            return Color.white
        } else if isRight != nil && index == selected {
            return isRight! ? Color.green : Color.red
        } else {
            return Color.clear
        }
    }

    func getTextColor(index: Int) -> Color {
        if isRight == nil {
            return Color.white
        } else if isRight == false && index == selected {
            return Color.red
        } else if isRight == true && index == selected {
            return Color.green
        } else {
            return Color.white
        }
    }
    
    var body: some View {
        Button(action: { action?() } ,
               label: {
            Text(text)
                .foregroundColor(getTextColor(index: index))
                .font(.system(size: 22, weight: .semibold))
                .multilineTextAlignment(.center)
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.1)))
        })
        .shadow(
            color: getShadowColor(index: index),
            radius: index == selected ? (isRight == nil ? 5 : 7) : 0
        )
    }
}

