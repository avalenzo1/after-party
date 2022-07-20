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
    @State var birthday:String = ""
    @State var budget:String = ""
}

struct HomeView: View {
    @StateObject var viewModel = FormViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        TextField("First Name", text: $viewModel.firstName)
                        TextField("Last Name", text: $viewModel.lastName)
                        TextField("Birthday", text: $viewModel.birthday)
                        TextField("Budget", text: $viewModel.budget)
                    }
                }
            }
            .navigationTitle("Home")
        }
    }
}
