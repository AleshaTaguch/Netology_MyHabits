//
//  AppDelegate.swift
//  MyHabits
//
//  Created by tertyshniy on 29.03.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let habitsNavigationController: UINavigationController = {
        let habitsNavigationController = UINavigationController()
        habitsNavigationController.tabBarItem = UITabBarItem(title: Consts.TabPage.habitPageName, image: UIImage(systemName: "rectangle.grid.1x2"), tag: 0)
        habitsNavigationController.tabBarItem.selectedImage = UIImage(systemName: "rectangle.grid.1x2.fill")
        habitsNavigationController.setViewControllers([HabitsViewController()], animated: true)
        return habitsNavigationController
    }()
    
    let infoNavigationController: UINavigationController = {
        let infoNavigationController = UINavigationController()
        infoNavigationController.tabBarItem = UITabBarItem(title: Consts.TabPage.infoPageName, image: UIImage(systemName: "info.circle"), tag: 1)
        infoNavigationController.tabBarItem.selectedImage = UIImage(systemName: "info.circle.fill")
        infoNavigationController.setViewControllers([InfoViewController()], animated: true)
        return infoNavigationController
    }()

    
    lazy var rootTabBarController: UITabBarController = {
        let rootTabBarController = UITabBarController()
        rootTabBarController.viewControllers = [self.habitsNavigationController,self.infoNavigationController]
        rootTabBarController.tabBar.backgroundColor = .systemGray6
        rootTabBarController.tabBar.layer.borderWidth = 0.5
        rootTabBarController.tabBar.layer.borderColor = UIColor.lightGray.cgColor
        UITabBar.appearance().tintColor = UIColor.purple
        return rootTabBarController
    }()
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)

        window?.rootViewController = rootTabBarController
        
        window?.makeKeyAndVisible()
        
        return true
    }

}

