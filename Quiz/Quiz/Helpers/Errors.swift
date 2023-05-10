//
//  Errors.swift
//  Quiz
//
//  Created by Olha Dzhyhirei on 5/2/23.
//

import SwiftUI

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case unableToComplete
}

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}

struct AlertContext {
    
    static let invalidData      = AlertItem(title: Text("Server Error"),
                                            message: Text("The data recieved from the server was invalid."),
                                            dismissButton: .default(Text("OK")))
    
    static let invalidResponse  = AlertItem(title: Text("Server Error"),
                                            message: Text("Invalid response from the server. Please try again."),
                                            dismissButton: .default(Text("OK")))
    
    static let invalidURL       = AlertItem(title: Text("Server Error"),
                                            message: Text("There was an issue connecting to the server."),
                                            dismissButton: .default(Text("OK")))
    
    static let unableToComplete = AlertItem(title: Text("Server Error"),
                                            message: Text("Unable to complete your request please check internet connection."),
                                            dismissButton: .default(Text("OK")))
}
