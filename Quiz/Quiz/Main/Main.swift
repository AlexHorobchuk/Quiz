//
//  ContentView.swift
//  Quiz
//
//  Created by Olha Dzhyhirei on 5/2/23.
//

import SwiftUI

struct Main: View {
    
    @StateObject var mainVM = MainVM()
    @StateObject var navigation = NavigationHelper()
    
    var body: some View {
        NavigationView {
            BaseView() {
                Group {
                    if !mainVM.categories.isEmpty {
                        VStack {
                            
                            Spacer(minLength: 50)
                            
                            ScrollView {
                                ForEach(mainVM.categories, id: \.self.name) { category in
                                    NavigationLink(
                                        destination: GameSetter(storage: StorageController(category: category.name),
                                                                gameSetterVM: GameSetterVM(category: category)),
                                        isActive: $navigation.showNextView,
                                        label: { MainButton(text: category.name) })
                                    .padding(10)
                                    
                                }
                                .padding(.horizontal)
                            }
                            
                            Spacer(minLength: 50)
                        }
                        
                    } else {
                        LoadingView()
                    }
                }
            }
            .onAppear(perform: { mainVM.setCategorys() })
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: Settings(), label: {
                        Image(systemName: "gearshape")
                    })
                }
            }
        }
        .environmentObject(navigation)
        .alert(item: $mainVM.alert) { alert in
            Alert(title: alert.title, message: alert.message, dismissButton: alert.dismissButton)
        }
        .accentColor(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}
