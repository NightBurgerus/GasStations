//
//  ColoredImage.swift
//  AZS
//
//  Created by Паша Терехов on 01.01.2023.
//

import SwiftUI

struct ColoredImage: View {
    var image: Image
    var color: Color
    
    var body: some View {
        Rectangle().fill(color).mask(Rectangle().mask(image.resizable().scaledToFit()))
    }
}
