//
//  NoteViewController.swift
//  Notes
//
//  Created by Bart Jacobs on 06/07/2017.
//  Copyright © 2017 Cocoacasts. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController {

    // MARK: - Properties

    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var contentsTextView: UITextView!
    
    // Mark: -
    
    var note: Note?

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Edit Note"
        
        setupView()
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

    }
    
    // MARK: - Helper Methods
    
    private func setupView() {
        setupTitleTextField()
        setupContentsTextView()
    }
    
    private func setupTitleTextField() {
        titleTextField.text = note?.title
    }
    
    private func setupContentsTextView() {
        contentsTextView.text = note?.contents
    }

}
