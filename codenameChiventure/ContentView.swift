//
//  ContentView.swift
//  codenameChiventure
//
//  Created by Anthony Valenzo on 7/19/22.
//

import SwiftUI
import UserNotifications

struct ContentView:View {
    @StateObject var router = TabRouter()
    
    init() {
        
    }
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            Group {
                switch router.tab {
                    case .HomeView:
                        HomeView()
                        .environmentObject(router)
                    case .ExploreView:
                        ExploreView()
                        .environmentObject(router)
                    case .SettingsView:
                        SettingsView()
                        .environmentObject(router)
                }
            }
            
            let tabItems:[TabItem] = [
                TabItem(text: "Explore", icon: "map", tab: .ExploreView),
                TabItem(text: "Search", icon: "sparkle.magnifyingglass", tab: .HomeView),
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
