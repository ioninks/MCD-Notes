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

        static let Note = "Note"
        static let AddNote = "AddNote"

    }

    // MARK: - Properties

    @IBOutlet var notesView: UIView!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var tableView: UITableView!

    // MARK: -

    private var coreDataManager = CoreDataManager(modelName: "Notes")
    
    private lazy var fetchedResultsController: NSFetchedResultsController<Note> = {
        // Create Fetch Request
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        // Configure Fetch Request
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: #keyPath(Note.updatedAt), ascending: false)
        ]
        // Create Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: self.coreDataManager.managedObjectContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        // Configure Fetched Results Controller
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()

    // MARK: -

    private var hasNotes: Bool {
        guard let notes = fetchedResultsController.fetchedObjects else {
            return false
        }
        return notes.count > 0
    }

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
        
        updateView()
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
        case Segue.Note:
            guard let destination = segue.destination as? NoteViewController else {
                return
            }
            guard
                let indexPath = tableView.indexPathForSelectedRow
            else {
                return
            }
            // Fetch Note
            let note = fetchedResultsController.object(at: indexPath)
            
            // Configure Destination
            destination.note = note
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
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("Unable to Perform Fetch Request")
            print("\(error), \(error.localizedDescription)")
        }
    }
}

extension NotesViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        guard let sections = fetchedResultsController.sections else {
            return 0
        }
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = fetchedResultsController.sections?[section] else {
            return 0
        }
        return section.numberOfObjects
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Fetch Note
        let note = fetchedResultsController.object(at: indexPath)
        
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

    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        guard editingStyle == .delete else {
            return
        }
        let note = fetchedResultsController.object(at: indexPath)
        
        note.managedObjectContext?.delete(note)
    }

}

extension NotesViewController: NSFetchedResultsControllerDelegate { }
