//
//  UIApplication.swift
//  AZS
//
//  Created by Паша Терехов on 04.01.2023.
//

import UIKit

extension UIApplication {
    static func resignFirstResponder() {
        self.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
