//
//  ProfileModel.swift
//  AZS
//
//  Created by Паша Терехов on 07.01.2023.
//

import Foundation

struct ProfileResponse: ResponseProtocol, Codable {
    var response: Bool
    var data: ProfileData
}

struct ProfileData: Codable {
    let firstName: String
    let lastName: String
}

struct ProfileLogoutResponse: ResponseProtocol, Codable {
    var response: Bool
    var data: ProfileLogoutData
}

struct ProfileLogoutData: Codable {
    
}
