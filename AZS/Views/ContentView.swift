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
    @StateObject private var controllers = Controllers()
    @StateObject private var profile     = Profile()
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        ZStack {
            TabView {
                MapView().tag(0).tabItem {
                    Image(systemName: "map")
                    Text(Res.strings.tabBar.map)
                }.introspectTabBarController { tabBarController in
                    if controllers.tabBarController == nil {
                        DispatchQueue.main.async {
                            controllers.tabBarController = tabBarController
                            controllers.configureTabBar()
                        }
                    }
                }
                FeedView().tag(1).tabItem {
                    Image(systemName: "newspaper")
                    Text(Res.strings.tabBar.news)
                }
                
                ProfileWrapper().tag(2).tabItem {
                    Image(systemName: "person")
                    Text(profileTabBarText)
                }
            }
            .environmentObject(controllers)
            .environmentObject(profile)
            .accentColor(accentColor())
        }
        .onAppear {
            configureView()
        }
    }
    
    private func configureView() {
        UserDefaults.standard.updateData(to: profile)
    }
    
    private func accentColor() -> Color {
        if colorScheme == .dark {
            return Res.colors.white
        } else {
            return Res.colors.blue
        }
    }
    
    private var profileTabBarText: String {
        if profile.isSignedIn {
            return String((profile.firstName + " " + profile.lastName).prefix(10))
        }
        return Res.strings.tabBar.profile
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
