//
//  LoadingScreen.swift
//  AZS
//
//  Created by Паша Терехов on 08.01.2023.
//

import SwiftUI

struct StartView: View {
    @Environment(\.colorScheme) private var colorScheme
    @State private var showsLabel = false
    @State private var showsImage = false
    @State private var mainOpacity = true
    
    var body: some View {
        VStack {
            Spacer()
            BoldText(Res.strings.appName, fontSize: .s24).opacity(showsLabel ? 1.0 : 0).offset(y: showsLabel ? 0 : 20)
            Spacer()
            Group {
                if colorScheme == .dark {
                    Res.images.gasPistolWhite
                } else {
                    Res.images.gasPistolBlack
                }
            }
            .opacity(showsImage ? 1.0 : 0).offset(y: showsImage ? 0 : 20).frame(width: 200, height: 200)
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width)
        .opacity(mainOpacity ? 1.0 : 0)
        .background(colorScheme == .light ? Color.white : Color.black)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.easeIn(duration: 0.5)) {
                    showsLabel = true
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(.easeIn(duration: 0.5)) {
                    showsImage = true
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.3) {
                withAnimation(.easeIn(duration: 0.7)) {
                    mainOpacity = false
                    showsLabel = false
                    showsImage = false
                }
            }
        }
    }
}
