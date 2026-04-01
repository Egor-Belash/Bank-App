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
        let mainVC = ViewController()
        let settingsVC = SettingsViewController()
        let mainNavVC = UINavigationController(rootViewController: mainVC)
        let settingsNavVC = UINavigationController(rootViewController: settingsVC)
        
        tabBarController?.selectedIndex = 0
        
        mainNavVC.tabBarItem = UITabBarItem(
            title: "Main",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )
        
        settingsNavVC.tabBarItem = UITabBarItem(
            title: "Settings",
            image: UIImage(systemName: "gear"),
            selectedImage: UIImage(systemName: "gear.fill")
        )

        viewControllers = [mainNavVC, settingsNavVC]
    }
}
