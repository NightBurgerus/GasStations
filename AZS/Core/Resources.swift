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
        static let darkGray  = Color("dark_gray")
        static let blue      = Color("blue")
        static let white     = Color("white")
        static let black     = Color("black")
    }
    struct strings {
        struct map {
            static let warning = NSLocalizedString("user_location_warning", comment: "")
            static let goToSettings = NSLocalizedString("user_go_to_settings", comment: "")
            
            struct gasStation {
                static let label = NSLocalizedString("gas_station_label", comment: "")
                static let address = NSLocalizedString("gas_station_address", comment: "")
                static let phone = NSLocalizedString("gas_station_phone_number", comment: "")
                static let gasolinePrice = NSLocalizedString("gas_station_gasoline_price", comment: "")
            }
        }
        struct tabBar {
            static let map = NSLocalizedString("tabbar_map", comment: "")
            static let news = NSLocalizedString("tabbar_news", comment: "")
            static let profile = NSLocalizedString("tabbar_profile", comment: "")
        }
    }
    struct fonts {
        static let regular10 = Font.system(size: 10, weight: .regular)
        static let regular14 = Font.system(size: 14, weight: .regular)
        static let regular16 = Font.system(size: 16, weight: .regular)
        
        static let bold10    = Font.system(size: 10, weight: .bold)
        static let bold14    = Font.system(size: 14, weight: .bold)
        static let bold16    = Font.system(size: 16, weight: .bold)
    }
    
    struct images {
        static let gasPistolWhite = ColoredImage(image: Image("gas_pistol"), color: Color.white)
        static let gasPistolBlack  = ColoredImage(image: Image("gas_pistol"), color: Color.black)
    }
}
