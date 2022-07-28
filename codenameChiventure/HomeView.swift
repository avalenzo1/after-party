//
//  HomeView.swift
//  codenameChiventure
//
//  Created by Anthony Valenzo on 7/19/22.
//

import SwiftUI
import Sliders

enum Category: String, CaseIterable, Identifiable {
    case any, park, museum, bar
    var id: Self { self }
}

class HomeFormViewModel: ObservableObject {
    @Published var budget:Double = 0.0
    @State var squadSize:Int = 0
    @Published var category:Category = .any 
}

struct HomeView: View {
    @StateObject var viewModel = HomeFormViewModel()
    @State var range = 0.0...20.0
    
    var data = ["Free", "< $10", "$10-20","$20-50", "$50-100", "100+"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Budget")) {
                    // Budget Field
                    Text("Below are the types of Budget Inputs")
                    
                    RangeSlider(range: $range, in: 0...100, step: 1)
                    
                    ZStack {
                        Rectangle()
                            .fill(.red)
                            .frame(width: .infinity, height: 3)
                        
                        HStack {
                            ForEach(data, id: \.self) { item in
                                Button(action: {
                                    
                                }, label: {
                                    ZStack {
                                        Circle()
                                            .frame(width:.infinity)
                                            .font(.caption)
                                        Text(item)
                                            .foregroundColor(.white)
                                    }
                                })
                            }
                        }
                    }
                }
                
                Section(header: Text("Squad")) {
                    // People Field
                    
                    TextField("Total number of people", value: $viewModel.squadSize, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("Category")) {
                    Picker("Category", selection: $viewModel.category) {
                        Text("Any").tag(Category.any)
                        Text("Park").tag(Category.museum)
                        Text("Museum").tag(Category.park)
                        Text("Museum").tag(Category.bar)
                    }
                }
                
                Button(action: {
                    // TODO: Redirect User to TabView: MapView
                    
                }, label: {
                    Text("Find the fun! 🎉")
                    .frame(minWidth: 0, maxWidth: .infinity)
                })
                .tint(.red)
                .buttonStyle(.borderedProminent)
                .listRowBackground(Color.red)
            }
            .navigationTitle("Home")
        }
    }
}
