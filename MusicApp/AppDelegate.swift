//
//  AppDelegate.swift
//  MusicApp
//
//  Created by Trung Le on 9/23/19.
//  Copyright © 2019 Trung Le. All rights reserved.
//

import UIKit
import FacebookCore


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    static let backColor = UIColor(red:0.33, green:0.33, blue:0.33, alpha:1.0)
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = self.window else { fatalError("No Window") }
//        let navigation = UINavigationController(rootViewController: setupTabBarController())
        window.rootViewController = setupTabBarController()
        window.makeKeyAndVisible()
        
        return true
    }
    func setupTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.barTintColor = AppDelegate.backColor
        
        let home_vc = HomeVC()
        let nvHome = UINavigationController(rootViewController: home_vc)
        home_vc.tabBarItem = UITabBarItem(title: "Trang chủ", image: UIImage(named: "home"), tag: 1)
        
        let search_vc = SearchVC()
        let nvSearch = UINavigationController(rootViewController: search_vc)
        search_vc.tabBarItem = UITabBarItem(title: "Tìm kiếm", image: UIImage(named: "search"), tag: 2)
        
        let library_vc = LibraryVC()
        let nvLibrary = UINavigationController(rootViewController: library_vc)
        library_vc.tabBarItem = UITabBarItem(title: "Thư viện", image: UIImage(named: "library"), tag: 3)
        
        
        tabBarController.viewControllers = [nvHome, nvSearch, nvLibrary]
        return tabBarController
    }
    
    
}

