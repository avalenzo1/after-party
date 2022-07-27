//
//  HomeView.swift
//  codenameChiventure
//
//  Created by Anthony Valenzo on 7/19/22.
//

import SwiftUI

// TO DO: Figure out a way to save these inputs?
// Maybe when you open the app for the first time you answer these and they stay in settings

class SettingsFormViewModel: ObservableObject {
    @State var firstName:String = ""
    @State var lastName:String = ""
    @State var birthdate:Date = Date()
}

struct SettingsView: View {
    @StateObject var viewModel = SettingsFormViewModel()
    
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
            }
        }
    }
}
