//
//  AppDelegate.swift
//  VideoPlayer
//
//  Created by Sergio on 17.04.23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = VideoViewController()
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()

        return true
    }
}
