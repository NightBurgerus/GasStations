//
//  GasStationModel.swift
//  AZS
//
//  Created by Паша Терехов on 01.01.2023.
//

import Foundation
import MapKit

struct GasStation: Identifiable, Codable {
    let id: UUID
    let address: String
    let latitude: Double
    let longitude: Double
    let phone: String
    let gasoline: Gasoline
    let images: [String]
}

struct Gasoline: Codable {
    let price: Dictionary<String, Int>
}

extension GasStation {
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

