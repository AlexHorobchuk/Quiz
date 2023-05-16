//
//  Statistic.swift
//  Quiz
//
//  Created by Olha Dzhyhirei on 5/15/23.
//

import SwiftUI

struct Statistic: View {
    
    var results = StorageManager.shared.fetchResults()
    
    var body: some View {
        BaseView() {
            VStack {
                StatisticBar()
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.white, lineWidth: 1)
                        .opacity(0.5))
                    .padding(.vertical, 10)
                    .padding(.top, 50)
                
                VStack {
                    ScrollView {
                        ForEach(results) { result in
                            StatisticResult(result: result)
                        }
                    }
                }
                
                Spacer(minLength: 20)
            }
            .padding(.horizontal)
        }
    }
}
