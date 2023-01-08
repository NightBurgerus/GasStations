//
//  Text.swift
//  AZS
//
//  Created by Паша Терехов on 04.01.2023.
//

import SwiftUI

struct BoldText: View {
    var text: String
    private var font: Font = Res.fonts.bold10
    
    init(_ text: String, fontSize: FontSizes) {
        self.text = text
        switch fontSize {
        case .s10: font = Res.fonts.bold10
        case .s14: font = Res.fonts.bold14
        case .s16: font = Res.fonts.bold16
        case .s24: font = Res.fonts.bold24
        }
    }
    var body: some View {
        Text(text).font(font)
    }
}

struct RegularText: View {
    var text: String
    private var font: Font = Res.fonts.regular10
    
    init(_ text: String, fontSize: FontSizes) {
        self.text = text
        switch fontSize {
        case .s10: font = Res.fonts.regular10
        case .s14: font = Res.fonts.regular14
        case .s16: font = Res.fonts.regular16
        case .s24: font = Res.fonts.regular24
        }
    }
    var body: some View {
        Text(text).font(font)
    }
}

enum FontSizes {
    case s10
    case s14
    case s16
    case s24
}


