//
//  GasStationModel.swift
//  AZS
//
//  Created by Паша Терехов on 01.01.2023.
//

import Foundation
import MapKit

struct GasStationResponse: ResponseProtocol, Codable {
    var response: Bool
    var data: [GasStation]
}

struct GasStation: Identifiable, Codable {
    let id: Int
    let address: String
    let latitude: Double
    let longitude: Double
    let phone: String
    let gasoline: Gasoline
}

struct Gasoline: Codable {
    let price: Dictionary<String, Double>
}

extension GasStation {
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

