//
//  Labels.swift
//  Quiz
//
//  Created by Olha Dzhyhirei on 5/6/23.
//

import SwiftUI

struct QuestionText: View {
    
    var text: String
    
    var body: some View {
        
        Text(text)
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .font(.system(size: 24, weight: .semibold))
            .multilineTextAlignment(.center)
            .lineLimit(nil)
            .padding(15)
    }
}
