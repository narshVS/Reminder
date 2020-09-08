//
//  SelectedListTableViewController.swift
//  Homework 11-13 Ovsyuk
//
//  Created by Влад Овсюк on 02.08.2020.
//  Copyright © 2020 Vlad Ovsyuk. All rights reserved.
//

import UIKit

/// final?
class SelectedListTableViewController: UITableViewController {
    
    // MARK: - Outlet
    
    @IBOutlet weak var titleListLabel: UINavigationItem! // Navigation title
    @IBOutlet weak var newReminderButton: UIBarButtonItem! // Button for crate new note
    @IBOutlet weak var noRemindersLabel: UILabel! // Label empty list
    
    // MARK: - Private properties
    
    /// Better name it `notes`
    private var listNote: [RemindeNoteModel] = []
    private var isDeleteOrSave: Bool = false // Bool for save and delete note
    
    // MARK: - Properties
    
    var listSegueModel: ListSegueModel?
    
    // MARK: - Lyfe cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// Avoid using force unwrapping.
        listNote.append(contentsOf: listSegueModel!.listNoteArray)
        setListNote()
        emptyListCheck()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        defauldTitleSet()
    }
    
    // MARK: - Private metod
    
    /// Customization navigation title and color for list
    /// Better name it `setNotes()`
    private func setListNote() {
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
    
    /// Need for navigation title in MyListTableViewController, without metod him he paints
    /// Better name it `setDefaultTitle()`
    private func defauldTitleSet() {
        navigationController?.navigationBar.largeTitleTextAttributes = [ NSAttributedString.Key.foregroundColor: UIColor.black]
    }
    
    /// Metod display "No teminders" when list empty
    /// Better name it `configureEmptyState()`
    private func emptyListCheck() {
        if listNote.isEmpty {
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
        listNote.append(RemindeNoteModel(id: listNote.endIndex+1, list: titleListLabel.title!, title: "TO DOO", description: "Coming soon..."))
        isDeleteOrSave = true
        tableView.reloadData()
        emptyListCheck()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listNote.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:  "ReminderNoteCell", for: indexPath) as! ReminderNoteCell
        
        /// Avoid using force unwrapping. Better use optional chaining here.
        cell.list = listSegueModel!.title // Need for button color set
        
        cell.configure(titleNoteModel: listNote[indexPath.row], titleDescriptionModel: listNote[indexPath.row])
        
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
            listNote.remove(at: indexPath.row)
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
                myListTableViewController.newList = listNote
            case "Education":
                myListTableViewController.educationList = listNote
            case "Swift Homework":
                myListTableViewController.swiftHomeworkList = listNote
            case "Podcast":
                myListTableViewController.podcastList = listNote
            case "Books":
                myListTableViewController.booksList = listNote
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
