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

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Edit Note"
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }

}
