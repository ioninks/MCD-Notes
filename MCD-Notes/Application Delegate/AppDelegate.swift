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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let coreDataManager = CoreDataManager(modelName: "Notes")
        print(coreDataManager.managedObjectContext)
        
        return true
    }
}

