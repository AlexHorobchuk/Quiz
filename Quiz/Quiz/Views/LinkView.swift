//
//  LinkView.swift
//  Quiz
//
//  Created by Olha Dzhyhirei on 5/5/23.
//

import SwiftUI

struct LinkView: View {
    let text: String
    let destination: String
    
    var body: some View {
        
        VStack {
            Link(destination: URL(string: destination)!,
                 label: {
                HStack {
                    Text(text)
                        .foregroundColor(.white)
                        .font(.system(size: 22))
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .opacity(0.5)
                    
                    
                }
                .padding(.vertical)
                .foregroundColor(.white)
            })
            
            Divider()
                .background(Color.white)
                .opacity(0.5)
            
        }
        .padding(.horizontal, 20)
    }
}
