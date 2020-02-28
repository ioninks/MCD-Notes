//
//  NoteViewController.swift
//  Notes
//
//  Created by Bart Jacobs on 06/07/2017.
//  Copyright © 2017 Cocoacasts. All rights reserved.
//

import UIKit
import CoreData

class NoteViewController: UIViewController {

    // MARK: - Segues

    private enum Segue {

        static let Categories = "Categories"

    }

    // MARK: - Properties

    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var contentsTextView: UITextView!

    // MARK: -

    var note: Note?
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Edit Note"

        setupView()
        setupNotificationHandling()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Update Note
        if let title = titleTextField.text, !title.isEmpty {
            note?.title = title
        }

        note?.updatedAt = Date()
        note?.contents = contentsTextView.text
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }

        switch identifier {
        case Segue.Categories:
            guard let destination = segue.destination as? CategoriesViewController else {
                return
            }

            // Configure Destination
            destination.note = note
        default:
            break
        }
    }

    // MARK: - View Methods

    private func setupView() {
        setupTitleTextField()
        setupContentsTextView()
    }
    
    private func updateCategoryLabel() {
        // Configure Category Label
        categoryLabel.text = note?.category?.name ?? "No category"
    }

    // MARK: -

    private func setupTitleTextField() {
        // Configure Title Text Field
        titleTextField.text = note?.title
    }

    private func setupContentsTextView() {
        // Configure Contents Text View
        contentsTextView.text = note?.contents
    }
    
    private func setupNotificationHandling() {
        
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(
            self,
            selector: #selector(managedObjectContextObjectsDidChange(_:)),
            name: Notification.Name.NSManagedObjectContextObjectsDidChange,
            object: note?.managedObjectContext
        )
    }
    
    // MARK: - Notification Handling
    
    @objc private func managedObjectContextObjectsDidChange(
        _ notification: Notification
    ) {
        guard let userInfo = notification.userInfo else {
            return
        }
        guard let updates = userInfo[NSUpdatedObjectsKey] as? Set<NSManagedObject> else {
            return
        }
        if (updates.filter { $0 == note }).count > 0 {
            updateCategoryLabel()
        }
    }

}
