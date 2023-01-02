//
//  Triangle.swift
//  AZS
//
//  Created by Паша Терехов on 01.01.2023.
//

import SwiftUI

struct Triangle: View {
    var width: CGFloat
    var height: CGFloat
    var color = Color.black
    
    var body: some View {
        ColoredImage(image: Image("triangle"), color: color).frame(width: width, height: height)
    }
}
