//
//  ViewController.swift
//  Notes
//
//  Created by Bart Jacobs on 05/07/2017.
//  Copyright © 2017 Cocoacasts. All rights reserved.
//

import UIKit
import CoreData

class NotesViewController: UIViewController {

    // MARK: - Segues

    private enum Segue {

        static let AddNote = "AddNote"

    }

    // MARK: - Properties

    @IBOutlet var notesView: UIView!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    private var notes: [Note]? {
        didSet {
            updateView()
        }
    }
    
    private var hasNotes: Bool {
        guard let notes = notes else {
            return false
        }
        return notes.count > 0
    }

    // MARK: -

    private var coreDataManager = CoreDataManager(modelName: "Notes")

    // MARK: -

    private let estimatedRowHeight = CGFloat(44.0)

    // MARK: -

    private lazy var updatedAtDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, HH:mm"
        return dateFormatter
    }()

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Notes"

        setupView()
        
        fetchNotes()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }

        switch identifier {
        case Segue.AddNote:
            guard let destination = segue.destination as? AddNoteViewController else {
                return
            }

            // Configure Destination
            destination.managedObjectContext = coreDataManager.managedObjectContext
        default:
            break
        }
    }

    // MARK: - View Methods

    private func setupView() {
        setupMessageLabel()
        setupTableView()
    }

    private func updateView() {
        tableView.isHidden = !hasNotes
        messageLabel.isHidden = hasNotes
    }

    // MARK: -

    private func setupMessageLabel() {
        messageLabel.text = "You don't have any notes yet."
    }

    // MARK: -

    private func setupTableView() {
        tableView.isHidden = true
        tableView.estimatedRowHeight = estimatedRowHeight
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    // MARK: -
    
    private func fetchNotes() {
        // Create Fetch Request
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        // Configure Fetch Request
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: #keyPath(Note.updatedAt), ascending: false)
        ]
        // Perform Fetch Request
        coreDataManager.managedObjectContext.performAndWait {
            do {
                // Execute Fetch Request
                let notes = try fetchRequest.execute()
                
                // Update Notes
                self.notes = notes
                
                // Reload Table View
                self.tableView.reloadData()
                
            } catch {
                let fetchError = error as NSError
                print("Unable to Perform Fetch Request")
                print("\(fetchError), \(fetchError.localizedDescription)")
            }
        }
    }

}

extension NotesViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return hasNotes ? 1 : 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let notes = notes else {
            return 0
        }
        return notes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Fetch Note
        guard let note = notes?[indexPath.row] else {
            fatalError("Unexpected Index Path")
        }
        
        // Dequeue Reusable Cell
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: NoteTableViewCell.reuseIdentifier,
                for: indexPath
            ) as? NoteTableViewCell
        else {
            fatalError("Unexpected Index Path")
        }
        
        cell.titleLabel.text = note.title
        cell.contentsLabel.text = note.contents
        cell.updatedAtLabel.text = note.updatedAt
            .map { updatedAtDateFormatter.string(from: $0) }

        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
    }

}
