//
//  String.swift
//  AZS
//
//  Created by Паша Терехов on 06.01.2023.
//

import Foundation

extension String {
    static func regex(_ regex: String, in string: String) -> Bool {
        let rgx = try? NSRegularExpression(pattern: regex)
        if rgx == nil {
            return false
        }
        return rgx!.matches(in: string, range: .init(location: 0, length: string.count)).count > 0
    }
}
