//
//  LoadingView.swift
//  Quiz
//
//  Created by Olha Dzhyhirei on 5/7/23.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            Spacer()
            ProgressView("Loading")
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                .scaleEffect(2)
                .frame(width: 300, height: 300)
            Spacer()
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
