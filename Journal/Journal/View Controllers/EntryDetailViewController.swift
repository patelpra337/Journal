//
//  EntryDetailViewController.swift
//  ios-journal-coredata
//
//  Created by patelpra on 2/17/20.
//  Copyright © 2020 Crus Technologies. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var moodSegmentedControl: UISegmentedControl!
    
    var entry: Entry? {
        didSet {
            updateViews()
        }
    }
    var entryController: EntryController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = titleTextField.text, !title.isEmpty, let body = bodyTextView.text, !body.isEmpty else { return }
        
        let mood = JournalMood.allCases[moodSegmentedControl.selectedSegmentIndex]
        
        if let entry = entry {
            entryController?.updateEntry(entry: entry, title: title, mood: mood, bodyText: body)
        } else {
            entryController?.createEntry(title: title, mood: mood, bodyText: body, context: CoreDataStack.shared.mainContext)
        }
        navigationController?.popViewController(animated: true)
    }
    
    func updateViews() {
        guard isViewLoaded else { return }
        
        title = entry?.title ?? "Create Entry"
        titleTextField.text = entry?.title
        bodyTextView.text = entry?.bodyText
        
        if let mood = JournalMood(rawValue: entry?.mood ??
            JournalMood.normal.rawValue), let moodIndex =
            JournalMood.allCases.firstIndex(of: mood) {
            moodSegmentedControl.selectedSegmentIndex = moodIndex
        }
    }
}
