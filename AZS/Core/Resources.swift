//
//  Resources.swift
//  AZS
//
//  Created by Паша Терехов on 01.01.2023.
//

import Foundation
import SwiftUI

struct Res {
    struct colors {
        static let lightGray = Color("light_gray")
        static let darkGray = Color("dark_gray")
        static let blue     = Color("blue")
    }
    struct strings {
        struct map {
            static let warning = NSLocalizedString("user_location_warning", comment: "")
            static let goToSettings = NSLocalizedString("user_go_to_settings", comment: "")
        }
    }
    struct fonts {
        static let regular10 = Font.system(size: 10, weight: .regular)
        static let regular14 = Font.system(size: 14, weight: .regular)
        static let regular16 = Font.system(size: 16, weight: .regular)
    }
    
    struct images {
        static let gasPistolWhite = ColoredImage(image: Image("gas_pistol"), color: Color.white)
        static let gasPistolBlack  = ColoredImage(image: Image("gas_pistol"), color: Color.black)
    }
}
