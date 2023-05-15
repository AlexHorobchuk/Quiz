//
//  Extras.swift
//  Quiz
//
//  Created by Olha Dzhyhirei on 5/6/23.
//

import SwiftUI

struct Getter {
    
    static let shared = Getter()
    
    private init() {}
    
    func categoryImage(category: String) -> String {
        switch category {
        case "Statistics":
            return "star.fill"
        case "Create":
            return "plus.circle.fill"
        case "Restart":
            return "arrow.triangle.2.circlepath"
        case "Join":
            return "person.fill.badge.plus"
        case "Menu":
            return "list.bullet.circle.fill"
        case "Next":
            return "checkmark"
        case "Single player":
            return "person.fill"
        case "Multiplayer":
            return "person.2.fill"
        case "Sport":
            return "soccerball"
        case "Art and Literature":
            return "photo"
        case "History":
            return "text.book.closed"
        case "Geography":
            return "globe.europe.africa"
        case "General Knowledge":
            return "graduationcap"
        case "Music":
            return "music.note"
        case "TV Series and Films":
            return "video"
        case "Science and Nature":
            return "cloud.sun.bolt"
        default:
            return "questionmark"
        }
    }
}

struct ParticleEffectView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIView {
        let particleEmitter = CAEmitterLayer()
        particleEmitter.emitterPosition = CGPoint(x: UIScreen.main.bounds.width / 2, y: -50)
        particleEmitter.emitterShape = .line
        particleEmitter.emitterSize = CGSize(width: UIScreen.main.bounds.width, height: 1)
        particleEmitter.renderMode = .additive
        
        let image = UIImage(systemName: "star.fill")
        let particle = CAEmitterCell()
        particle.contents = image?.cgImage
        particle.birthRate = 15
        particle.lifetime = 2
        particle.velocity = 200
        particle.velocityRange = 5
        particle.emissionLongitude = .pi
        particle.scale = 0.5
        particle.scaleRange = 0.2
        particle.alphaSpeed = -0.2
        
        particleEmitter.emitterCells = [particle]
        
        let particleView = UIView()
        particleView.layer.addSublayer(particleEmitter)
        
        return particleView
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}
