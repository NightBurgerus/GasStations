//
//  ResponseProtocol.swift
//  AZS
//
//  Created by Паша Терехов on 03.01.2023.
//

import Foundation

protocol ResponseProtocol {
    associatedtype Value
    var response: Bool { get }
    var data: Value { get }
}
