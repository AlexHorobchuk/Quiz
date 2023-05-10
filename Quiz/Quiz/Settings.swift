//
//  Settings.swift
//  Quiz
//
//  Created by Olha Dzhyhirei on 5/5/23.
//

import SwiftUI

struct Settings: View {
    
    var body: some View {
        BaseView() {
            VStack {
                Text("Settings")
                    .foregroundColor(.white)
                
                LinkView(text: "Privacy policy", destination: "https://www.apple.com")
                
                LinkView(text: "Terms of use", destination: "https://www.apple.com")
                
                Spacer()
            }
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
