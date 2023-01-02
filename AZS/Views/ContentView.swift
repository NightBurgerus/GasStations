//
//  ContentView.swift
//  AZS
//
//  Created by Паша Терехов on 01.01.2023.
//

import SwiftUI

// TODO:
// - локация пользователя
// - При смене локали уходит фон таббара


struct ContentView: View {
    @StateObject var controllers = Controllers()
    
    var body: some View {
        ZStack {
            TabView {
                MapView().tag(0).tabItem {
                    Text("1").foregroundColor(Color("appForeground"))
                }.introspectTabBarController { tabBarController in
                    DispatchQueue.main.async {
                        controllers.tabBarController = tabBarController
                        controllers.configureTabBar()
                    }
                }
                FeedView().tag(1).tabItem {
                    Text("2").foregroundColor(Color("appForeground"))
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
