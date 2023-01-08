//
//  FeedModels.swift
//  AZS
//
//  Created by Паша Терехов on 08.01.2023.
//

import Foundation

struct FeedResponse: ResponseProtocol, Codable {
    let response: Bool
    let data: [FeedData]
}

struct FeedData: Codable, Hashable {
    let id: Int
    let text: String
}

struct DetailInfoResposne: ResponseProtocol, Codable {
    let response: Bool
    let data: DetailInfoData
}

struct DetailInfoData: Codable {
    let label: String
    let text: String
    let image: String?
}
