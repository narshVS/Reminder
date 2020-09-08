//
//  NewReminderTableViewCintroller.swift
//  Homework 11-13 Ovsyuk
//
//  Created by Влад Овсюк on 06.08.2020.
//  Copyright © 2020 Vlad Ovsyuk. All rights reserved.
//

import UIKit

/// final?
class NewReminderTableViewCintroller: UITableViewController {
    
    // MARK: - Outlet
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var circleImageView: UIImageView!
    @IBOutlet weak var titleListLabel: UILabel! // Selected list for save
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    // MARK: - Properties
    
    var listTitle = "New List >"
    
    // MARK: - Life cycle
    
    override func viewWillAppear(_ animated: Bool) {
        titleListLabel.text = listTitle
        circleColorSet()
    }
    
    // MARK: - Private metod
    
    /// Better name it `setCircleColor()`
    private func circleColorSet() {
        /// Refactor picking a color somehow. You're using it in each VC.
        switch titleListLabel.text {
        case "New List >":
            circleImageView.tintColor = .systemGreen
        case "Education List >":
            circleImageView.tintColor = .systemPink
        case "Swift List >":
            circleImageView.tintColor = .systemIndigo
        case "Podcast List >":
            circleImageView.tintColor = .systemPurple
        case "Books List >":
            circleImageView.tintColor = .systemYellow
        default:
            circleImageView.tintColor = .systemGreen
        }
    }
    
    // MARK: - Action
    
    @IBAction func canselButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func addButton(_ sender: Any) {
        performSegue(withIdentifier: "NewReminderUnwindSegue", sender: self)
    }
    
    /// Segue - Select list for save
    @IBSegueAction func selectListTapped(_ coder: NSCoder) -> ListReminderTableViewController? {
        let controller = ListReminderTableViewController(coder: coder)
        /// Avoid using force unwrapping. Better use optional bidning here.
        controller?.selectList = SelectListSegueModel(list: titleListLabel.text!)
        return controller
    }
    
    // MARK: - Table view delegate
    
    /// Don't leave empty methods.
    @IBAction func unwindToNewReminderTableViewCintroller(_ sender: UIStoryboardSegue) {}
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let myListTableViewController = segue.destination as? MyListTableViewController else {
            return
        }
        if noteTextView.text != "" {
            switch titleListLabel.text {
            case "New List >":
                myListTableViewController.newList.append(RemindeNoteModel(id: myListTableViewController.newList.endIndex + 1, list: "New",  title: noteTextView.text, description: descriptionTextView.text))
            case "Education List >":
                myListTableViewController.educationList.append(RemindeNoteModel(id: myListTableViewController.educationList.endIndex + 1, list: "Education",  title: noteTextView.text, description: descriptionTextView.text))
            case "Swift List >":
                myListTableViewController.swiftHomeworkList.append(RemindeNoteModel(id: myListTableViewController.swiftHomeworkList.endIndex + 1, list: "Swift",  title: noteTextView.text, description: descriptionTextView.text))
            case "Podcast List >":
                myListTableViewController.podcastList.append(RemindeNoteModel(id: myListTableViewController.podcastList.endIndex + 1, list: "Podcast",  title: noteTextView.text, description: descriptionTextView.text))
            case "Books List >":
                myListTableViewController.booksList.append(RemindeNoteModel(id: myListTableViewController.booksList.endIndex + 1, list: "Books",  title: noteTextView.text, description: descriptionTextView.text))
            default:
                break
            }
            /// It's a strange method to update the view.
            /// Why don't using `.setNeedsDisplay()` or `setNeedsLayout()` depending on the purpose?
            myListTableViewController.viewWillAppear(true) // Update view
        } else {
            dismiss(animated: true)
        }
    }
}
