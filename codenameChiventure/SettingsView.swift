//
//  HomeView.swift
//  codenameChiventure
//
//  Created by Anthony Valenzo on 7/19/22.
//

import SwiftUI

class FormViewModel: ObservableObject {
    @State var firstName:String = ""
    @State var lastName:String = ""
    @State var birthdate:Date = Date()
    @State var budget:Double = 10
}

struct SettingsView: View {
    @StateObject var viewModel = FormViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        TextField("First Name", text: $viewModel.firstName)
                        TextField("Last Name", text: $viewModel.lastName)
                    }
                    
                    Section {
                        // ...Date() means that you can't be born in the future.
                        
                        DatePicker("Birthdate", selection: $viewModel.birthdate, in: ...Date(), displayedComponents: .date)
                    }
                    
                    Section {
                        Text("Budget")
                        Slider(value: $viewModel.budget, in: 0...100, step: 5)
                            .accentColor(.red)
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}
