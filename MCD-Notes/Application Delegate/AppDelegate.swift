//
//  AppDelegate.swift
//  MCD-Notes
//
//  Created by Konstantin Ionin on 26.02.2020.
//  Copyright © 2020 Konstantin Ionin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private let coreDataManager = CoreDataManager(modelName: "Notes")

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Instantiate Initial View Controller
        guard
            let viewController = storyboard.instantiateInitialViewController()
                as? ViewController
        else {
            fatalError("Unable to Load Initial View Controller")
        }
        
        viewController.coreDataManager = coreDataManager
        
        window?.rootViewController = viewController
        
        return true
    }
}

