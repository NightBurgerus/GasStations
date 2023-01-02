//
//  Controllers.swift
//  AZS
//
//  Created by Паша Терехов on 02.01.2023.
//

import SwiftUI

// Вспомогательный класс для работы с контроллерами
class Controllers: ObservableObject {
    @Published var tabBarController: UITabBarController? = nil
    let animationDuration = 0.3
    
    func configureTabBar() {
        DispatchQueue.main.async {
            self.tabBarController?.tabBar.backgroundColor = UIColor(named: "appBackground")
        }
    }
    
    func hideTabBar(withoutAnimation: Bool = false) {
        guard let tabBar = tabBarController?.tabBar else {
            return
        }
        
        if tabBar.isHidden {
            return
        }
        
        if !withoutAnimation {
            UIView.animate(withDuration: animationDuration) {
                tabBar.frame.origin = CGPoint(x: 0, y: UIScreen.main.bounds.height)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
                tabBar.isHidden = true
                // Для обновления safe area после скрытия таббара,
                // необходимо явно изменить фрейм у таббара
                
                // Пояснение: оператор ! здесь можно использовать без
                // проблем, потому что к этому моменту имеется переменная
                // tabBar. Она берётся из контроллера, а если контроллера нет,
                // то до этого блока программа не дойдёт.
                let frame = self.tabBarController!.view.frame
                self.tabBarController!.view.frame = frame.insetBy(dx: 1, dy: 1)
                self.tabBarController!.view.frame = frame
            }
        } else {
            tabBar.isHidden = true
        }
    }
    
    func setTabBar(withoutAnimation: Bool = false) {
        guard let tabBar = tabBarController?.tabBar else {
            return
        }
        
        if !tabBar.isHidden {
            return
        }
        
        tabBar.isHidden = false
        if !withoutAnimation {
            tabBar.frame.origin = CGPoint(x: 0, y: UIScreen.main.bounds.height)
            UIView.animate(withDuration: animationDuration) {
                tabBar.frame.origin = CGPoint(x: 0, y: UIScreen.main.bounds.height - tabBar.frame.height)
            }
        } else {
            tabBar.frame.origin = CGPoint(x: 0, y: UIScreen.main.bounds.height - tabBar.frame.height)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
            let frame = self.tabBarController!.view.frame
            self.tabBarController!.view.frame = frame.insetBy(dx: 1, dy: 1)
            self.tabBarController!.view.frame = frame
        }
    }
}
