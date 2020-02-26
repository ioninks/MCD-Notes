//
//  ViewController.swift
//  MCD-Notes
//
//  Created by Konstantin Ionin on 26.02.2020.
//  Copyright © 2020 Konstantin Ionin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var coreDataManager: CoreDataManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(coreDataManager?.managedObjectContext ?? "No Managed Object Context")
    }


}

