//
//  ContentView.swift
//  codenameChiventure
//
//  Created by Anthony Valenzo on 7/19/22.
//

import SwiftUI

struct ContentView:View {
    var body: some View {
        VStack {
            TabView {
                MapView()
                    .badge(0)
                    .tabItem {
                        Label("Maps", systemImage: "tray.and.arrow.down.fill")
                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
