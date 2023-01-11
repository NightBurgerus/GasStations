//
//  Introspection.swift
//  AZS
//
//  Created by Паша Терехов on 02.01.2023.
//

import SwiftUI

struct CustomViewControllerInspector: UIViewControllerRepresentable {
    typealias UIViewControllerType = CustomViewController
    var introspect: IntrospectType
    var tabBarHandler: (UITabBarController?) -> () = { _ in }
    var navigationBarHandler: (UINavigationController?) -> () = { _ in }
    
    func makeUIViewController(context: Context) -> CustomViewController {
        let controller = CustomViewController()
        switch introspect {
        case .UITabBarController:
            DispatchQueue.main.async {
                tabBarHandler(controller.introspectTabBarController())
            }
        case .UINavigationController:
            DispatchQueue.main.async {
                navigationBarHandler(controller.introspectNavigationController())
            }
        }
        return controller
    }
    
    func updateUIViewController(_ uiViewController: CustomViewController, context: Context) {
    }
}

extension CustomViewControllerInspector {
    enum IntrospectType {
        case UITabBarController
        case UINavigationController
    }
}

class CustomViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(UILabel())
    }
    
    func introspectTabBarController() -> UITabBarController? {
        return tabBarController
    }
    
    func introspectNavigationController() -> UINavigationController? {
        return navigationController
    }
}
