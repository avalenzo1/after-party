//
//  ContentView.swift
//  codenameChiventure
//
//  Created by Anthony Valenzo on 7/19/22.
//

import SwiftUI

struct ContentView:View {
    @State public var UITabBarColor = UIColor.clear
    
    init() {
        // Changes the color of the TabView Color to white
        UITabBar.appearance().backgroundColor = UITabBarColor

    }
    
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
                    .onTapGesture {
                        UITabBarColor = UIColor.white
                        print("SDGS")
                    }
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
