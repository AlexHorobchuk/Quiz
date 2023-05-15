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

extension Double {
    
    func convertToMinutesAndSeconds() -> Double {
        let minutes = Int(self) / 60
        let seconds = Int(self) % 60
        return Double(minutes) + Double(seconds) / 100
    }
    
    func time() -> String {
        return  String(format: "%.2f", self.convertToMinutesAndSeconds())
    }
}

extension String {
    
    func decodeResult() -> MultiplayerResult? {
        let components = self.components(separatedBy: ",")
        guard components.count == 4 else {
            return nil
        }
        guard let name = components[0].removingPercentEncoding,
              let gaveUp = components[1] == "true" ? true : false,
              let result = Int(components[2]),
              let time = Double(components[3]) else {
            return nil
        }
        return MultiplayerResult(name: name, gaveUp: gaveUp, result: result, time: time)
    }
}
    
extension MultiplayerResult {
    func incodeResult() -> String {
        let gaveUpString = gaveUp ? "true" : "false"
        return "\(name),\(gaveUpString),\(result),\(time)"
    }
}


