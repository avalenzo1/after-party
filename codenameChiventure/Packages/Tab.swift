//
//  Tab.swift
//  codenameChiventure
//
//  Created by Anthony Valenzo on 7/29/22.
//

import SwiftUI

enum TabView {
    case HomeView
    case MapView
    case SettingsView
}

final class TabRouter: ObservableObject {
    @Published var tab: TabView = .MapView
    
    func change(to TabView: TabView) {
        self.tab = TabView
    }
}

struct TabItem: Identifiable {
    var id = UUID()
    var text: String
    var icon: String
    var tab: TabView
}

struct AppTabView: View {
    var router:TabRouter
    var tabItems:Array<TabItem>
    
    var body: some View {
        HStack {
            // https://designcode.io/swiftui-ios15-tab-bar-model-and-looping-data
            ForEach(tabItems) { item in
                Button {
                    router.change(to: item.tab)
                } label: {
                    VStack {
                        Image(systemName: item.icon)
                            .font(.system(size: 22))
                            .frame(height: 25)
                        Text(item.text)
                            .font(.body)

                    }
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(
                        (router.tab == item.tab ? palette[0] : palette[1])
                    )
                }
            }
        }
        .padding(.top, 15)
        .frame(height: 100, alignment: .top)
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 25))
        .frame(maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
    }
}
