//
//  TabViewController.swift
//  MovieLog
//
//  Created by KangMingyo on 1/16/24.
//

import UIKit

final class TabViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tab1 = HomeViewController()
        tab1.title = "홈"
        
        let tab2 = CalendarViewController()
        tab2.title = "캘린더"
        
        let tab3 = ChartViewController()
        tab2.title = "차트"
        
        let nav1 = UINavigationController(rootViewController: tab1)
        let nav2 = UINavigationController(rootViewController: tab2)
        let nav3 = UINavigationController(rootViewController: tab3)
        
        nav1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Calendar", image: UIImage(systemName: "calendar"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Chart", image: UIImage(systemName: "chart.bar"), tag: 3)
        
        setViewControllers([
            nav1, nav2, nav3
        ], animated: true)
    }
}
