//
//  GasolineAnnotationView.swift
//  AZS
//
//  Created by Паша Терехов on 01.01.2023.
//

import SwiftUI

struct GasStationView: View {
    @Environment(\.colorScheme) private var colorScheme
    @State private var userInterfaceStyle = ColorScheme.light
    
    var body: some View {
        ZStack {
            ColoredCircle
            StationIcon.offset(y: -11)
        }
        .offset(y: -22)
        .onAppear {
            configureView()
        }
        .onChange(of: colorScheme) { value in
            userInterfaceStyle = value
        }
    }
    
    private func configureView() {
        userInterfaceStyle = colorScheme
    }
    
    private var StationIcon: some View {
        Group {
            if userInterfaceStyle == ColorScheme.dark {
                return Res.images.gasPistolWhite
            } else {
                return Res.images.gasPistolBlack
            }
        }.frame(width: 30, height: 30)
    }
    
    private var ColoredCircle: some View {
        VStack(spacing: 0) {
            Circle()
                .fill(colorScheme == .dark ? Res.colors.darkGray : Res.colors.lightGray)
                .overlay(Circle().stroke(
                    colorScheme == .dark ? Color.white : Color.black, lineWidth: 4)
                )
            Triangle(width: 30, height: 20, color: colorScheme == .dark ? Color.white : Color.black).offset(y: -2)
        }.frame(width: 50, height: 70)
    }
}
