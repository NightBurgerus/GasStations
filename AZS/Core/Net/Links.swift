//
//  Links.swift
//  AZS
//
//  Created by Паша Терехов on 03.01.2023.
//

import Foundation

struct Links {
    private static let base = "HOSTNAME"
    struct Profile {
        private static let profileBase = "/profile"
        static let getProfile = base + profileBase + "/getProfile/"
        static let logout     = base + profileBase + "/logout"
        static let delProfile = base + profileBase + "/delete"
    }
    struct Authorization {
        private static let authorizationBase = "/auth"
        static let login = base + authorizationBase + "/login/"
        static let register = base + authorizationBase + "register/"
    }
}


