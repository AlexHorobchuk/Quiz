//
//  NavigationController.swift
//  Quiz
//
//  Created by Olha Dzhyhirei on 5/10/23.
//

import SwiftUI

class NavigationHelper: ObservableObject {
    
    @Published var showNextView = false
    
    var action: (()->())?
    
}
