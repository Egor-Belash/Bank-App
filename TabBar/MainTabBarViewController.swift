//
//  MainTabBarViewController.swift
//  Bank App
//
//  Created by Egor on 01.04.2026.
//

import UIKit

final class MainTabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }
    
    private func setupTabs() {
        let mapVC = MapRouter.build()
        let mainVC = MainRouter.build()
        let settingsVC = SettingsRouter.build()
        
        let mapNavVC = UINavigationController(rootViewController: mapVC)
        let mainNavVC = UINavigationController(rootViewController: mainVC)
        let settingsNavVC = UINavigationController(rootViewController: settingsVC)
        
        selectedIndex = 1
        
        mapNavVC.tabBarItem = UITabBarItem(
            title: String(localized: .map),
            image: UIImage(systemName: "map"),
            selectedImage: UIImage(systemName: "map.fill")
        )
        
        mainNavVC.tabBarItem = UITabBarItem(
            title: String(localized: .tabBarNameMain),
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )
        
        settingsNavVC.tabBarItem = UITabBarItem(
            title: String(localized: .tabBarNameSettings),
            image: UIImage(systemName: "gear"),
            selectedImage: UIImage(systemName: "gear.fill")
        )

        viewControllers = [mapNavVC, mainNavVC, settingsNavVC]
    }
}
