//
//  SelectedListTableViewController.swift
//  Reminder
//
//  Created by Влад Овсюк on 02.08.2020.
//  Copyright © 2020 Vlad Ovsyuk. All rights reserved.
//

import UIKit

final class SelectedListTableViewController: UITableViewController {
    
    // MARK: - Outlet
    
    @IBOutlet weak var titleListLabel: UINavigationItem! // Navigation title
    @IBOutlet weak var newReminderButton: UIBarButtonItem! // Button for crate new note
    @IBOutlet weak var noRemindersLabel: UILabel! // Label empty list
    
    // MARK: - Private properties
    
    private var notes: [List] = []
    private var notesManager = NotesManager()
    
    // MARK: - Properties
    
    var listTitle = ""
    
    // MARK: - Lyfe cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        configureEmptyState()
    }
    
    /// Needed for "Incomplete Closing"
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setViewCollor()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        setDefaultTitle()
    }

    // MARK: - Private metod
    
    /// Loading data from CoreData and selecting notes
    private func loadData() {
        notes.removeAll()
        notesManager.fetchGroups { [weak self] notes in
            notes.forEach { note in
                if note.listName == self?.listTitle {
                    self?.notes.append(note)
                }
            }
        }
    }
    
    /// Customization navigation title and color for list
    private func setViewCollor() {
        titleListLabel.title = listTitle
        
        switch titleListLabel.title {
        case "New":
            navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemGreen]
            newReminderButton.tintColor = .systemGreen
        case "Education":
            navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemPink]
            newReminderButton.tintColor = .systemPink
        case "Swift Homework":
            navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemIndigo]
            newReminderButton.tintColor = .systemIndigo
        case "Podcast":
            navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemPurple]
            newReminderButton.tintColor = .systemPurple
        case "Books":
            navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemYellow]
            newReminderButton.tintColor = .systemYellow
        default:
            break
        }
    }
    
    /// Metod display "No teminders" when list empty
    private func configureEmptyState() {
        if notes.isEmpty {
            noRemindersLabel.isHidden = false
            noRemindersLabel.text = "No reminders"
        } else {
            noRemindersLabel.isHidden = true
        }
    }
    
    private func setDefaultTitle() {
        navigationController?.navigationBar.largeTitleTextAttributes = [ NSAttributedString.Key.foregroundColor: UIColor.label]
    }
    
    // MARK: - Action
    
    /// Add new note, To doo...
    @IBAction func newReminderButtopTapped(_ sender: Any) {
        notesManager.addNote(title: "TO DOO", descriptionNote: "Coming soon...", id: notes.count, listName: listTitle)
        loadData()
        tableView.reloadData()
        configureEmptyState()
    }
    
    // MARK: - Table view data source12
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:  "NoteCell", for: indexPath) as! NoteCell

        cell.list = titleListLabel.title ?? "Title" // Need for button color set
        
        cell.configure(titleNote: notes[indexPath.row], titleDescriptionModel: notes[indexPath.row])
        
        /// Custom separators
        Timer.scheduledTimer(withTimeInterval: 0, repeats: false) { (timer) in
            cell.removeSectionSeparators()
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool { true }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            notesManager.deleteNote(object: notes[indexPath.row]) // delete note from CoreData
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            configureEmptyState()
        }
    }
}

/// New separators
extension UITableViewCell {
    func removeSectionSeparators() {
        for subview in subviews {
            if subview != contentView && subview.frame.width == frame.width {
                subview.removeFromSuperview()
            }
        }
    }
}
