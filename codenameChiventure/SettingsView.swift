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
    @Published var budget:Double = 0.0
}

struct SettingsView: View {
    @StateObject var viewModel = FormViewModel()
    
    var body: some View {
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
                    TextField("Budget", value: $viewModel.budget, formatter: NumberFormatter())
                    Slider(value: $viewModel.budget, in: 0.0...100.0, step: 5)
                        .accentColor(.red)
                }
            }
        }
    }
}
