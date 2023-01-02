//
//  ContentView.swift
//  AZS
//
//  Created by Паша Терехов on 01.01.2023.
//

import SwiftUI

// TODO:
// - локация пользователя


struct ContentView: View {
    @StateObject var controllers = Controllers()
    var body: some View {
        ZStack {
            TabView {
                MapView().tag(0).tabItem {
                    Text("1")
                }.introspectTabBarController { tabBarController in
                    controllers.tabBarController = tabBarController
                }
                FeedView().tag(1).tabItem {
                    Text("2")
                }
            }.environmentObject(controllers)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
