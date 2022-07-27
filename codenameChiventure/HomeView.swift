//
//  HomeView.swift
//  codenameChiventure
//
//  Created by Anthony Valenzo on 7/19/22.
//

import SwiftUI

class HomeFormViewModel: ObservableObject {
    @Published var budget:Double = 0.0
    @State var noOfPeople:Int = 1
    @State var category:String = ""
}

struct HomeView: View {
    @StateObject var viewModel = HomeFormViewModel()
    
    var body: some View {
        VStack {
            Section {
                Text("Budget (TEMPORARY)")
                
                TextField("Budget", value: $viewModel.budget, formatter: NumberFormatter())
                Slider(value: $viewModel.budget, in: 0.0...100.0, step: 1)
                    .accentColor(.red)
            }
            
            Section {
                Text("How many People? (TEMPORARY)")
                
            }
        }
    }
}
