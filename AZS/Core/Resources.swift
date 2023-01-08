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
        struct auth {
            static let label = NSLocalizedString("login_label", comment: "")
            static let login = NSLocalizedString("login_placeholder", comment: "")
            static let password = NSLocalizedString("password_placeholder", comment: "")
            static let loginButton = NSLocalizedString("log_in_button", comment: "")
        }
        struct register {
            static let label = NSLocalizedString("register_label", comment: "")
            static let login = NSLocalizedString("login_placeholder", comment: "")
            static let password = NSLocalizedString("password_placeholder", comment: "")
            static let repeatPassword = NSLocalizedString("repeat_password_placeholder", comment: "")
            static let email = NSLocalizedString("email_placeholder", comment: "")
            static let firstName = NSLocalizedString("first_name_placeholder", comment: "")
            static let lastName = NSLocalizedString("last_name_placeholder", comment: "")
            static let registerButton = NSLocalizedString("register_button", comment: "")
        }
        struct profile {
            static let username  = NSLocalizedString("profile_username", comment: "")
            static let firstName = NSLocalizedString("profile_first_name", comment: "")
            static let lastName  = NSLocalizedString("profile_last_name", comment: "")
            static let edit      = NSLocalizedString("profile_edit", comment: "")
            static let exit      = NSLocalizedString("profile_exit", comment: "")
            static let delete    = NSLocalizedString("profile_delete", comment: "")
            static let deleteSheet = NSLocalizedString("profile_del_sheet", comment: "")
            static let exitSheet   = NSLocalizedString("profile_exit_sheet", comment: "")
            static let yes         = NSLocalizedString("profile_confirm", comment: "")
            static let no          = NSLocalizedString("profile_dismiss", comment: "")
        }
        struct toast {
            static let emptyFields = NSLocalizedString("toast_empty_fields", comment: "")
            static let incorrectEmail = NSLocalizedString("toast_incorrect_email", comment: "")
            static let passwordLength = NSLocalizedString("toast_password_length", comment: "")
            static let passwordsDontMatch = NSLocalizedString("toast_passwords_dont_match", comment: "")
            
            static let deletingAccountError = NSLocalizedString("toast_deleting_error", comment: "")
            static let deletingSuccess = NSLocalizedString("toast_deleting_completed", comment: "")
            static let exitError            = NSLocalizedString("toast_exit_error", comment: "")
            static let exitSuccess = NSLocalizedString("toast_exit_completed", comment: "")
        }
        struct errors {
            static let authError = NSLocalizedString("auth_error", comment: "")
        }
    }
    struct fonts {
        static let regular10 = Font.system(size: 10, weight: .regular)
        static let regular14 = Font.system(size: 14, weight: .regular)
        static let regular16 = Font.system(size: 16, weight: .regular)
        static let regular24 = Font.system(size: 24, weight: .regular)
        
        static let bold10    = Font.system(size: 10, weight: .bold)
        static let bold14    = Font.system(size: 14, weight: .bold)
        static let bold16    = Font.system(size: 16, weight: .bold)
        static let bold24    = Font.system(size: 24, weight: .bold)
    }
    
    struct images {
        static let gasPistolWhite = ColoredImage(image: Image("gas_pistol"), color: Color.white)
        static let gasPistolBlack  = ColoredImage(image: Image("gas_pistol"), color: Color.black)
    }
}
