//
//  FeedView.swift
//  AZS
//
//  Created by Паша Терехов on 01.01.2023.
//

import SwiftUI

struct FeedView: View {
    @State var showLoadingScreen = true
    var body: some View {
        ZStack {
            if showLoadingScreen {
                LoadingScreen()
            }
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                showLoadingScreen = false
            }
        }
    }
}
