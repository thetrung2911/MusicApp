//
//  AppDelegate.swift
//  MusicApp
//
//  Created by Trung Le on 9/23/19.
//  Copyright © 2019 Trung Le. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase

func setupTabBarController() -> UITabBarController {
    let tabBarController = UITabBarController()
    tabBarController.tabBar.barTintColor = AppDelegate.backgroundColor
    
    let home_vc = HomeVC()
    home_vc.tabBarItem = UITabBarItem(title: "Trang chủ", image: UIImage(named: "home"), tag: 1)
    
    let search_vc = SearchVC()
    search_vc.tabBarItem = UITabBarItem(title: "Tìm kiếm", image: UIImage(named: "search"), tag: 2)
    
    let library_vc = LibraryVC()
    library_vc.tabBarItem = UITabBarItem(title: "Thư viện", image: UIImage(named: "library"), tag: 3)
    
    tabBarController.viewControllers = [home_vc, search_vc, library_vc]
    return tabBarController
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    static let backgroundColor = UIColor(red:0.33, green:0.33, blue:0.33, alpha:1.0)
    static let ipConnect = "http://192.168.1.22:8888/"
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = self.window else { fatalError("No Window") }
        let loginVC = UINavigationController(rootViewController: LoginVC())
        window.rootViewController = loginVC
        window.makeKeyAndVisible()
        
        FirebaseApp.configure()
        return true
    }
    
    
    // phát nhạc trong nền
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default, options: [.mixWithOthers, .allowAirPlay])
            print("Playback OK")
            try AVAudioSession.sharedInstance().setActive(true)
            print("Session is Active")
        } catch {
            print(error)
        }
        return true
    }
    
}

