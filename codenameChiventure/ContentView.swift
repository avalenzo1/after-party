//
//  ContentView.swift
//  codenameChiventure
//
//  Created by Anthony Valenzo on 7/19/22.
//

import SwiftUI

struct ContentView:View {
    init() {
        UITabBar.appearance().barTintColor =
        UIColor.blue
    }
    
    var body: some View {
        TabView {
            MapView()
                .badge(0)
                .tabItem {
                    Label("Explore", systemImage: "map.fill")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
