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
    
    func hideTabBar(withoutAnimation: Bool = false) {
        guard let tabBar = tabBarController?.tabBar else {
            return
        }
        
        if tabBar.isHidden {
            return
        }
        
        if !withoutAnimation {
            withAnimation(.easeInOut(duration: animationDuration)) {
                tabBar.frame.origin = CGPoint(x: 0, y: UIScreen.main.bounds.height)
            }
            
            tabBar.isHidden = true
            // Для обновления safe area после скрытия таббара,
            // необходимо явно изменить фрейм у таббара
            
            // Пояснение: оператор ! здесь можно использовать без
            // проблем, потому что к этому моменту имеется переменная
            // tabBar. Она берётся из контроллера, а если контроллера нет,
            // то до этого блока программа не дойдёт.
            let frame = tabBarController!.view.frame
            tabBarController!.view.frame = frame.insetBy(dx: 1, dy: 1)
            tabBarController!.view.frame = frame
            return
        }
        tabBar.isHidden = true
    }
    
    func setTabBar(withoutAnimation: Bool = false) {
        guard let tabBar = tabBarController?.tabBar else {
            return
        }
        
        if !tabBar.isHidden {
            return
        }
        
        if !withoutAnimation {
            withAnimation(.easeInOut(duration: animationDuration)) {
                tabBar.frame.origin = CGPoint(x: 0, y: UIScreen.main.bounds.height - tabBar.frame.height)
            }
            
            tabBar.isHidden = false
            // Для обновления safe area после скрытия таббара,
            // необходимо явно изменить фрейм у таббара
            
            // Пояснение: оператор ! здесь можно использовать без
            // проблем, потому что к этому моменту имеется переменная
            // tabBar. Она берётся из контроллера, а если контроллера нет,
            // то до этого блока программа не дойдёт.
            let frame = tabBarController!.view.frame
            tabBarController!.view.frame = frame.insetBy(dx: 1, dy: 1)
            tabBarController!.view.frame = frame
            return
        }
        tabBar.isHidden = false
    }
}
