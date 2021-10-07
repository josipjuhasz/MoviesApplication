//
//  AppDelegate.swift
//  SeventhWeekTask
//
//  Created by Josip Juhasz on 27.06.2021..
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let initialViewController = UINavigationController(rootViewController: HomeViewController(homeViewModel: HomeVideoModelImpl(repository: RepositoryImpl(movieServiceAPI: MovieServiceAPI()))))
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        self.window?.rootViewController = initialViewController
        return true
    }
}

