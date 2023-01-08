//
//  BaseResponse.swift
//  AZS
//
//  Created by Паша Терехов on 08.01.2023.
//

import Foundation

struct BaseResponse: ResponseProtocol, Codable {
    var response: Bool
    var data: EmptyData
}

struct EmptyData: Codable {}
