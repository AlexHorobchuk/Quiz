//
//  StatisticBar.swift
//  Quiz
//
//  Created by Olha Dzhyhirei on 5/15/23.
//

import SwiftUI

struct StatisticBar: View {
    var body: some View {
        HStack {
            Text("Your \n Result")
                .foregroundColor(.white)
                .font(.system(size: 22, weight: .bold))
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .frame(width: 75)
            
            Divider()
                .background(Color.white)
                .opacity(0.5)
            
            ScaledImage(name: "trophy.fill", size: .init(width: 25, height: 25))
                .padding(.horizontal, 10)
            
            Divider()
                .background(Color.white)
                .opacity(0.5)
            
            Text("Enemy \n Result")
                .foregroundColor(.white)
                .font(.system(size: 22, weight: .bold))
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .frame(width: 75)
            
            Divider()
                .background(Color.white)
                .opacity(0.5)
            
            Text("Name")
                .lineLimit(1)
                .foregroundColor(.white)
                .font(.system(size: 22, weight: .bold))
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
            
        }
        .frame(maxWidth: .infinity)
        .frame(height: 70)
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.1)))
    }
}

struct StatisticBar_Previews: PreviewProvider {
    static var previews: some View {
        StatisticBar()
    }
}
