//
//  ViewController.swift
//  MCD-Notes
//
//  Created by Konstantin Ionin on 26.02.2020.
//  Copyright © 2020 Konstantin Ionin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    var coreDataManager =  CoreDataManager(modelName: "Notes")
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}

