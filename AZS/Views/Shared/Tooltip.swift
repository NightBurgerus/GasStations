//
//  Tooltip.swift
//  AZS
//
//  Created by Паша Терехов on 02.01.2023.
//

import SwiftUI

struct Tooltip<Content: View>: View {
    let content: Content
    let minHeight: CGFloat = 100
    let maxHeight: CGFloat = UIScreen.main.bounds.height / 2
    @State private var offset: CGFloat = 0
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10).fill(.white).overlay(
                VStack {
                    RoundedRectangle(cornerRadius: 50).fill(Res.colors.darkGray).frame(width: UIScreen.main.bounds.width / 5, height: 10)
                        .padding(.vertical, 10)
                    Spacer()
                }
            )
            VStack {
                content.padding(.top, 30)
                Spacer()
            }
            
        }.frame(minHeight: minHeight, maxHeight: maxHeight)
    }
}
