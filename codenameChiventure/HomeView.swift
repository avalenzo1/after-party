//
//  HomeView.swift
//  codenameChiventure
//
//  Created by Anthony Valenzo on 7/19/22.
//

import SwiftUI

enum Flavor: String, CaseIterable, Identifiable {
    case chocolate, vanilla, strawberry
    var id: Self { self }
}

class HomeFormViewModel: ObservableObject {
    @Published var budget:Double = 0.0
    @State var squadSize:Int = 0
    @State var category:String = ""
    @State var selectedFlavor: Flavor = .chocolate
}

struct HomeView: View {
    @StateObject var viewModel = HomeFormViewModel()
    
    var body: some View {
        NavigationView {
            Section {
                // Budget Field
                
//                TextField("Budget", value: $viewModel.budget, formatter: NumberFormatter())
                Slider(value: $viewModel.budget, in: 0.0...100.0, step: 1)
                    .accentColor(.red)
            }
            
            Section {
                // People Field
                
                TextField("Total number of people", value: $viewModel.squadSize, formatter: NumberFormatter())
                    .keyboardType(.numberPad)
            }
            
            Section {
                List {
                    Picker("Flavor", selection: $viewModel.selectedFlavor) {
                        Text("Chocolate").tag(Flavor.chocolate)
                        Text("Vanilla").tag(Flavor.vanilla)
                        Text("Strawberry").tag(Flavor.strawberry)
                    }
                }
            }
        }
        .navigationTitle("Home")
    }
}
