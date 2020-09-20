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
    @IBOutlet var tableViewOutlet: UITableView!
    
    // MARK: - Private properties
    
    private var notes: [RemindeNoteModel] = []
    private var isDeleteOrSave: Bool = false // Bool for save and delete note
    
    // MARK: - Properties
    
    var listSegueModel: ListSegueModel?
    
    // MARK: - Lyfe cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// Avoid using force unwrapping.
        notes.append(contentsOf: listSegueModel!.listNoteArray)
        setNotes()
        emptyListCheck()
    }
    
    // MARK: - Private metod
    
    /// Customization navigation title and color for list
    private func setNotes() {
        titleListLabel.title = listSegueModel?.title
        
        switch listSegueModel?.title {
        /// Better create an enum with string cases in order to reuse them in all the VCs.
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
    /// Better name it `configureEmptyState()`
    private func emptyListCheck() {
        if notes.isEmpty {
            noRemindersLabel.isHidden = false
            noRemindersLabel.text = "No reminders"
        } else {
            noRemindersLabel.isHidden = true
        }
    }
    
    // MARK: - Action
    
    /// Add new note, To doo...
    @IBAction func newReminderButtopTapped(_ sender: Any) {
        /// Separate `+` with whitespaces
        /// Avoid using force unwrapping. Better use nil-coaleasing here.
        notes.append(RemindeNoteModel(id: notes.endIndex+1, list: titleListLabel.title!, title: "TO DOO", description: "Coming soon..."))
        isDeleteOrSave = true
        tableView.reloadData()
        emptyListCheck()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:  "ReminderNoteCell", for: indexPath) as! ReminderNoteCell
        
        /// Avoid using force unwrapping. Better use optional chaining here.
        cell.list = listSegueModel!.title // Need for button color set
        
        cell.configure(titleNoteModel: notes[indexPath.row], titleDescriptionModel: notes[indexPath.row])
        
        // Custom separators
        /// Why using timer here?
        /// What's a profite?
        Timer.scheduledTimer(withTimeInterval: 0, repeats: false) { (timer) in
            cell.removeSectionSeparators()
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        /// We can omit the `return` keyword for the single line methods.
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            isDeleteOrSave = true
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            emptyListCheck()
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let myListTableViewController = segue.destination as? MyListTableViewController else {
            return
        }
        if isDeleteOrSave == true {
            switch titleListLabel.title {
            case "New":
                myListTableViewController.newList = notes
            case "Education":
                myListTableViewController.educationList = notes
            case "Swift Homework":
                myListTableViewController.swiftHomeworkList = notes
            case "Podcast":
                myListTableViewController.podcastList = notes
            case "Books":
                myListTableViewController.booksList = notes
            default:
                break
            }
        }
    }
}

/// New separators
extension UITableViewCell {
    func removeSectionSeparators() {
        for subview in subviews {
            /// It's a risky condition. Isn't it better to check for a height <= 1 ? :)
            /// P.S. we could just disable separator for the table view.
            if subview != contentView && subview.frame.width == frame.width {
                subview.removeFromSuperview()
            }
        }
    }
}
