//
//  Toast.swift
//  AZS
//
//  Created by Паша Терехов on 04.01.2023.
//

import SwiftUI

struct Toast: View {
    @Environment(\.colorScheme) private var colorScheme
    @State private var foregroundColor = Res.colors.white
    @State private var backgroundColor = Res.colors.black
    @Binding var isShowing: Bool
    var text: String
    
    var body: some View {
//        ZStack {
            
            HStack {
                InfoIcon()
                ToastText()
                Spacer()
            }
            .background(RoundedRectangle(cornerRadius: 20).fill(backgroundColor.opacity(0.8)))
//        }
//        .frame(height: 100)
        .padding(.horizontal, 20)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    isShowing = false
                }
            }
        }
    }
    
    private func InfoIcon() -> some View {
        VStack {
            ColoredImage(image: Image(systemName: "info.circle"), color: foregroundColor)
                .frame(width: 30, height: 30)
        }.padding(10)
    }
    
    private func ToastText() -> some View {
        HStack {
            VStack {
                RegularText(text, fontSize: .s14).foregroundColor(foregroundColor).multilineTextAlignment(.leading)
            }.padding(10)
        }
    }
}
