//
//  BaseScene.swift
//  Quiz
//
//  Created by Olha Dzhyhirei on 5/2/23.
//

import SwiftUI

import SwiftUI

struct BaseView<Content: View> : View {
    
    var content: () -> Content
    
    var body: some View {
        
        VStack {
            Spacer(minLength: 70)
            
            content()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(colors: [Color("Main2"), Color("Main1"), Color("Main2")], startPoint: .topLeading, endPoint: .bottomTrailing))
        .ignoresSafeArea()
    }
}
