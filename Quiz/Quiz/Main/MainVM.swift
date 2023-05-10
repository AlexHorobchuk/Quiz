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
    private var selectedCategory: Category?
    private var categoryName: String?
    
    func setCategory(category: Category) {
        selectedCategory = category
        categoryName = category.name
    }
    
    func getCategoryName() -> String {
        guard let categoryName = categoryName else { return "" }
        return categoryName
    }
    
    func getSelectedCategory() -> Category {
        guard let selectedCategory = selectedCategory else { return Category(_id: "1", name: "1") }
        return selectedCategory
    }
    
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
