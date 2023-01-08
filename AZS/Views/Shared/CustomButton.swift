//
//  CustomButton.swift
//  AZS
//
//  Created by Паша Терехов on 04.01.2023.
//

import SwiftUI

// Кастомная кнопка
struct CustomButton: View {
    var label: String
    var action: () -> ()
    @Environment(\.colorScheme) private var colorScheme
    @State private var foregroundColor = Res.colors.white
    @State private var backgroundColor = Res.colors.black
    
    var body: some View {
        BoldText(label, fontSize: .s14)
            .foregroundColor(foregroundColor)
            .padding(EdgeInsets(top: 20, leading: 35, bottom: 20, trailing: 35))
            .background(RoundedRectangle(cornerRadius: 15).fill(backgroundColor))
            .contentShape(RoundedRectangle(cornerRadius: 15))
            .onTapGesture {
                action()
            }
            .onAppear {
                if colorScheme == .dark {
                    foregroundColor = Res.colors.blue
                    backgroundColor = Res.colors.lightGray
                } else {
                    foregroundColor = Res.colors.white
                    backgroundColor = Res.colors.blue
                }
            }
    
    }
}
