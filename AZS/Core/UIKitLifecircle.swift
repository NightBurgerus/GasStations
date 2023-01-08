//
//  UIKitLifecircle.swift
//  AZS
//
//  Created by Паша Терехов on 08.01.2023.
//

import SwiftUI

struct UIKitWrapper: UIViewControllerRepresentable {
    let completion: () -> ()
    func makeUIViewController(context: Context) -> UIKitCircle {
        let vc = UIKitCircle(lifeStage: .viewDidLoad, completion: completion)
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIKitCircle, context: Context) {}
}


class UIKitCircle: UIViewController {
    var completion: () -> () = {}
    var lifeStage: LifeStage
    init(lifeStage: LifeStage, completion: @escaping () -> () = {}) {
        self.lifeStage = lifeStage
        self.completion = completion
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if lifeStage == .viewDidLoad {
            view.addSubview(UILabel())
            completion()
        }
    }
}


extension UIKitCircle {
    enum LifeStage {
        case viewDidLoad
        case viewWillAppear
    }
}
