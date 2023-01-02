//
//  UserLocationWarnings.swift
//  AZS
//
//  Created by Паша Терехов on 01.01.2023.
//

import SwiftUI

struct MapLocationRequest: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10).fill(Res.colors.darkGray).opacity(0.85)
            VStack {
                label.padding(.top, 10)
                
                Spacer()
                    
                HStack {
                    settingsButton
                    Spacer()
                }
                .padding(.bottom, 20).padding(.leading, 10)
                
            }
        }.padding(.horizontal, 16).frame(height: 100)
    }
    
    var label: some View {
        Text(Res.strings.map.warning).font(Res.fonts.regular14).foregroundColor(.white)
    }
    
    var settingsButton: some View {
        Text(Res.strings.map.goToSettings).font(Res.fonts.regular10).foregroundColor(Res.colors.blue).padding(.horizontal, 10)
            .background(
                RoundedRectangle(cornerRadius: 4).fill(.white).frame(height: 30)
            )
            .contentShape(RoundedRectangle(cornerRadius: 4))
            .onTapGesture {
                
            }
    }
}
