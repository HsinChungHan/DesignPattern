//
//  AppDelegate.swift
//  RabbleWabble_MVC
//
//  Created by 辛忠翰 on 2018/10/28.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
//        window?.rootViewController = QuestionViewController()
        let navi = UINavigationController(rootViewController: SelectQuestionGroupViewController())
//        let navi = UINavigationController(rootViewController: CreateQuestionGroupViewController())

        window?.rootViewController = navi
        return true
    }
}
