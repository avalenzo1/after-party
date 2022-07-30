//
//  ContentView.swift
//  codenameChiventure
//
//  Created by Anthony Valenzo on 7/19/22.
//

import SwiftUI
import UserNotifications

struct ContentView:View {
    var tabColor = UIColor.clear
    @StateObject var router = TabRouter()
    
    init() {
        // Changes the color of the TabView Color to white
        UITabBar.appearance().backgroundColor = tabColor

    }
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            Group {
                switch router.tab {
                    case .HomeView:
                        HomeView()
                        .environmentObject(router)
                    case .MapView:
                        MapView()
                        .environmentObject(router)
                    case .SettingsView:
                        SettingsView()
                        .environmentObject(router)
                }
            }
            
            let tabItems = [
                TabItem(text: "Home", icon: "house", tab: .HomeView),
                TabItem(text: "Explore", icon: "map", tab: .MapView),
                TabItem(text: "Settings", icon: "gearshape", tab: .SettingsView),
            ]

            
            AppTabView(router: router, tabItems: tabItems)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}
