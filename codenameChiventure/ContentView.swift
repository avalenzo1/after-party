//
//  ContentView.swift
//  codenameChiventure
//
//  Created by Anthony Valenzo on 7/19/22.
//

import SwiftUI

struct ContentView:View {
    var body: some View {
        TabView {
            HomeView()
                .badge(1)
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            MapView()
                .tabItem {
                    Label("Explore", systemImage: "map.fill")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}
