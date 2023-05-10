//
//  MainVM.swift
//  Quiz
//
//  Created by Olha Dzhyhirei on 5/7/23.
//

import SwiftUI

class MainVM: ObservableObject {
    
    @Published var categories: [Category] = []
    @Published var alert: AlertItem?
    
    
    func setCategorys() {
        NetworkManager.shared.fetchCategories() { [self] (result) in
            DispatchQueue.main.async {
                switch result {
                    
                case .success(let allCategories):
                    self.categories = allCategories.categories
                    
                case .failure(let error):
                    switch error {
                    case .invalidURL:
                        self.alert = AlertContext.invalidURL
                    case .invalidResponse:
                        self.alert = AlertContext.invalidResponse
                    case .invalidData:
                        self.alert = AlertContext.invalidData
                    case .unableToComplete:
                        self.alert = AlertContext.unableToComplete
                    }
                }
            }
        }
    }
}
