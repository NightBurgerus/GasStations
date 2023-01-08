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
    @StateObject private var controllers = Controllers()
    @StateObject private var profile     = Profile()
    @State private var showStartScreen = true
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
            
            if showStartScreen {
                StartView().ignoresSafeArea()
            }
        }
        .onAppear {
            configureView()
        }
        .viewDidLoad {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.showStartScreen = false
            }

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
