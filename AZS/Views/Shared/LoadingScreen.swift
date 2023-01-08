//
//  LoadingScreen.swift
//  AZS
//
//  Created by Паша Терехов on 03.01.2023.
//

import SwiftUI

// MARK: - Индикатор загрузки
struct LoadingScreen: View {
    @Environment(\.colorScheme) private var colorScheme
    @State private var foregroundColor: Color = Res.colors.blue
    @State private var backgroundColor: Color = Res.colors.lightGray
    @State private var startTrimming: CGFloat = 0.0
    @State private var endTrimming:   CGFloat = 0.0
    @State private var animationDuration = 0.01
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20).fill(backgroundColor).frame(width: 80, height: 80)
            LoadingCircle()
        }
        .onAppear {
            configureView()
        }
        .onChange(of: startTrimming + endTrimming) { value in
            DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
                self.animation()
            }
            
        }
    }
    
    private func animation() {
        // Анимация тримминга круга
        if startTrimming == 0.0 && endTrimming == 0.0 {
            withAnimation(.easeInOut(duration: animationDuration)) {
                endTrimming += 0.02
            }
        } else if startTrimming == 0.0 && endTrimming < 1.0 {
            withAnimation(.easeInOut(duration: animationDuration))  {
                endTrimming += 0.02
            }
        }
        else if startTrimming == 0.0 && endTrimming >= 1.0 {
            withAnimation(.easeInOut(duration: animationDuration)) {
                startTrimming += 0.02
            }
        } else if startTrimming < 1.0 && endTrimming >= 1.0 {
            withAnimation(.easeInOut(duration: animationDuration)) {
                startTrimming += 0.02
            }
        } else {
            startTrimming = 0.0
            endTrimming = 0.0
        }
    }
    
    private func configureView(){
        // Настройка представления индикатора загрузки
        if colorScheme == .dark {
            foregroundColor = Res.colors.white
            backgroundColor = Res.colors.darkGray
        } else {
            foregroundColor = Res.colors.blue
            backgroundColor = Res.colors.lightGray
        }
        withAnimation {
            endTrimming += 0.1
        }
    }
    private func LoadingCircle() -> some View {
        // Круг загрузки
        Circle().trim(from: startTrimming, to: endTrimming).stroke(foregroundColor, lineWidth: 5).frame(width: 40, height: 40).rotationEffect(.degrees(-90))
    }
}
