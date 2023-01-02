//
//  Introspection.swift
//  AZS
//
//  Created by Паша Терехов on 02.01.2023.
//

import SwiftUI

struct CustomViewControllerInspector: UIViewControllerRepresentable {
    typealias UIViewControllerType = CustomViewController
    var completion: (UITabBarController?) -> () = { _ in }
    
    func makeUIViewController(context: Context) -> CustomViewController {
        let controller = CustomViewController()
        DispatchQueue.global().async {
            completion(controller.introspectTabBarController())
        }
        return controller
    }
    
    func updateUIViewController(_ uiViewController: CustomViewController, context: Context) {
    }
    
//    func introspectTabBarController(_ customize: @escaping(UITabBarController?) -> ()) -> some View {
//        DispatchQueue.global().asyncAfter(deadline: .now() + 5) {
//            print("~ self.vc: ", vc)
//        }
//        return self
//    }
}

class CustomViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(UILabel())
    }
    
    func introspectTabBarController() -> UITabBarController? {
        return self.tabBarController
    }
}
