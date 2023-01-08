//
//  CustomNavigationStack.swift
//  AZS
//
//  Created by Паша Терехов on 08.01.2023.
//

import SwiftUI

// В SwiftUI 4.0 (iOS 16) NavigationView
// был изменён на NavigationStack.
// Чтобы всё работало на разных версиях осей,
// необходимо использовать кастомную вьюшку
struct CustomNavigationStack<Content: View>: View {
    let content: Content
    
    init(_ content: () -> Content) {
        self.content = content()
    }
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                content
            }
        } else {
            NavigationView {
                content
            }
        }
    }
}
