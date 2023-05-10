//
//  Extensions.swift
//  Quiz
//
//  Created by Olha Dzhyhirei on 5/5/23.
//

import SwiftUI


extension Question: Equatable {
    static func == (lhs: Question, rhs: Question) -> Bool {
        lhs._id == rhs._id
    }
}

struct ClearBackgroundView: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}

struct ClearBackgroundViewModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .background(ClearBackgroundView())
    }
}

extension View {
    func clearModalBackground() -> some View {
        self.modifier(ClearBackgroundViewModifier())
    }
}

extension Double {
    func convertToMinutesAndSeconds() -> Double {
        let minutes = Int(self) / 60
        let seconds = Int(self) % 60
        return Double(minutes) + Double(seconds) / 100
    }
}



