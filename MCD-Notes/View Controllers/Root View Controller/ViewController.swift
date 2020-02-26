//
//  ViewController.swift
//  MCD-Notes
//
//  Created by Konstantin Ionin on 26.02.2020.
//  Copyright © 2020 Konstantin Ionin. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    var coreDataManager =  CoreDataManager(modelName: "Notes")
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let entityDescription = NSEntityDescription.entity(
            forEntityName: "Note",
            in: coreDataManager.managedObjectContext
        ) {
            // Initialize Managed Object
            let note = NSManagedObject(
                entity: entityDescription,
                insertInto: coreDataManager.managedObjectContext
            )
            
            // Configure Managed Object
            note.setValue("My first note", forKey: "contents")
            note.setValue(Date(), forKey: "createdAt")
            note.setValue(Date(), forKey: "updatedAt")
            
            print(note)
            
            do {
                try coreDataManager.managedObjectContext.save()
            } catch {
                print("Unable to Save Managed Object Context")
                print("\(error), \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}

