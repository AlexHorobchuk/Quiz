//
//  ProgressTable.swift
//  Quiz
//
//  Created by Olha Dzhyhirei on 5/6/23.
//

import SwiftUI

struct ProgressTable: View {
    
    var averageTime: String
    
    var body: some View {
        HStack {
            Spacer()
            
            VStack {
                Text("Questions")
                    .font(.system(size: 20, weight: .bold))
                    .opacity(0.4)
                Text("0 - 10")
                    .font(.system(size: 24, weight: .bold))
            }
            .frame(maxWidth: .infinity)
            
            Divider()
                .background(Color.white)
                .opacity(0.5)
            
            VStack {
                Text("Avarage Time")
                    .font(.system(size: 20, weight: .bold))
                    .opacity(0.4)
                Text(averageTime)
                    .font(.system(size: 24, weight: .bold))
            }
            .frame(maxWidth: .infinity)
        }
        .foregroundColor(.white)
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.1)))
        .frame(height: 80)
        .padding(10)
    }
}

struct ProgressTable_Previews: PreviewProvider {
    static var previews: some View {
        ProgressTable(averageTime: "1.00").background(Color.black)
    }
}
