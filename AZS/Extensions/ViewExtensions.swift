//
//  ViewExtensions.swift
//  AZS
//
//  Created by Паша Терехов on 02.01.2023.
//

import SwiftUI

extension View {
    @ViewBuilder func tooltip<Content: View>(isShowing: Binding<Bool>, content: () -> Content) -> some View {
        if isShowing.wrappedValue {
            self.overlay(
                VStack {
                    Color.black.opacity(0.5).contentShape(Rectangle()).onTapGesture {
                        isShowing.wrappedValue = false
                    }
                    
                }
            )
        } else {
            self
        }
    }
    
    @ViewBuilder func introspectTabBarController(_ customize: @escaping(UITabBarController?) -> ()) -> some View {
        self.background(CustomViewControllerInspector() { tabBarController in
            customize(tabBarController)
        })
    }
}
