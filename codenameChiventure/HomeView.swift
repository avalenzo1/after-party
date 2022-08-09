//
//  HomeView.swift
//  codenameChiventure
//
//  Created by Anthony Valenzo on 7/19/22.
//

import SwiftUI
import Sliders

enum Category: String {
    case any = "any",
         park = "park",
         museum = "museum",
         bar = "bar",
         skyscraper = "skyscraper",
         other = "other"
    var id: Self { self }
}

enum Transportation: String, CaseIterable, Identifiable {
    case driving, transit, cycling, walking
    var id: Self { self }
}

class HomeFormViewModel: ObservableObject {
    @Published var budget:Double = 0.0
    @State var squadSize:Int = 0
    @Published var category:Category = .any
    @Published var transportation:Transportation = .walking
}

struct HomeView: View {
    @EnvironmentObject var router:TabRouter
    @StateObject var viewModel = HomeFormViewModel()
    @State var range = 0.0...20.0
    
    var body: some View {
        
        NavigationView {
            Form {
                Section(header: Text("Budget *")) {
                    // Budget Field
                    Text("Below are the types of Budget Inputs")
                    Text("From $\(range.lowerBound) to $\(range.upperBound)")
                    
                    RangeSlider(range: $range, in: 0...100, step: 10)
                }

                
                Section(header: Text("Squad *")) {
                    // People Field
                    
                    TextField("Total number of people", value: $viewModel.squadSize, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("Category")) {
                    Picker("Category", selection: $viewModel.category) {
                        Text("Any").tag(Category.any)
                        Text("Park").tag(Category.museum)
                        Text("Museum").tag(Category.park)
                        Text("Bar").tag(Category.bar)
                        Text("Other").tag(Category.other)
                    }
                }
                
                Section(header: Text("Transportation")) {
                    Picker("Transportation", selection: $viewModel.transportation) {
                        Text("Driving").tag(Transportation.driving)
                        Text("Transit").tag(Transportation.transit)
                        Text("Cycling").tag(Transportation.cycling)
                        Text("Walking").tag(Transportation.walking)
                    }
                }
                
                Button(action: {
                    // TODO: Redirect User to TabView: MapView
                    router.change(to: .ExploreView)
                }, label: {
                    Text("Find the fun! 🎉")
                    .frame(minWidth: 0, maxWidth: .infinity)
                })
                .tint(.clear)
                .buttonStyle(.borderedProminent)
                .listRowBackground(palette[0])
            }
            .navigationTitle("Home")
        }
    }
}
