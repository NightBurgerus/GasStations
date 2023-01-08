//
//  AuthModel.swift
//  AZS
//
//  Created by Паша Терехов on 05.01.2023.
//

import Foundation

struct AuthResponse: ResponseProtocol, Codable {
    var response: Bool
    var data: AuthData?
}

struct AuthData: Codable {
    let accessToken: String
}
