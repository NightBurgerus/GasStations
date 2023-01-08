//
//  Profile.swift
//  AZS
//
//  Created by Паша Терехов on 03.01.2023.
//

import SwiftUI

class Profile: ObservableObject {
    @Published var accessToken: String = "token"
    @Published var username: String    = "someUsername"
    @Published var password: String    = ""
    @Published var firstName: String   = "First"
    @Published var lastName: String    = "Last"
}

extension Profile {
    var isSignedIn: Bool {
        return !accessToken.isEmpty && !firstName.isEmpty && !lastName.isEmpty
    }
}
