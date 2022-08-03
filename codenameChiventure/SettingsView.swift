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
    @EnvironmentObject var router:TabRouter
    @StateObject var viewModel = SettingsFormViewModel()
    @State var formIsDisabled:Bool = true
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        TextField("First Name", text: $viewModel.firstName)
                            .disabled(formIsDisabled)
                        TextField("Last Name", text: $viewModel.lastName)
                            .disabled(formIsDisabled)
                    }
                    
                    Section {
                        // ...Date() means that you can't be born in the future.
                        
                        DatePicker("Birthdate", selection: $viewModel.birthdate, in: ...Date(), displayedComponents: .date)
                            .disabled(formIsDisabled)
                        
                    }
                }
            }
            .navigationTitle("Settings")
            .toolbar {
                // TODO: Make EditButton a convert disabled bool to false
                
                Button(formIsDisabled ? "Edit" : "Done") {
                    formIsDisabled = !formIsDisabled
                }
                .tint(.accentColor)
                .buttonBorderShape(.capsule)
            }
        }
    }
}
