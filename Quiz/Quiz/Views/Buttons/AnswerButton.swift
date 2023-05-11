//
//  CategoryButton.swift
//  Quiz
//
//  Created by Olha Dzhyhirei on 5/5/23.
//

import SwiftUI

struct AnswerButton: View {
    
    @Binding var selected: Int?
    @Binding var isRight: Bool?
    
    var action: (()->())?
    var text: String
    var index: Int
    
    var body: some View {
        Button(
            action: { action?() } ,
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
    
    func getShadowColor(index: Int) -> Color {
        if isRight == nil && index == selected {
            return Color.white
        }
        else if isRight != nil && index == selected {
            return isRight! ? Color.green : Color.red
        }
        else {
            return Color.clear
        }
    }

    func getTextColor(index: Int) -> Color {
        if isRight == nil {
            return Color.white
        }
        else if isRight == false && index == selected {
            return Color.red
        }
        else if isRight == true && index == selected {
            return Color.green
        }
        else {
            return Color.white
        }
    }
}

