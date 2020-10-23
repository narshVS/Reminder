//
//  NewReminderTableViewCintroller.swift
//  Reminder
//
//  Created by Влад Овсюк on 06.08.2020.
//  Copyright © 2020 Vlad Ovsyuk. All rights reserved.
//

import UIKit

final class NewReminderTableViewCintroller: UITableViewController {
    
    // MARK: - Outlet
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var circleImageView: UIImageView!
    @IBOutlet weak var titleListLabel: UILabel! // Selected list for save
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    // MARK: - Properties
    
    var listTitle = "New List >"
    
    // MARK: - Life cycle
    
    override func viewWillAppear(_ animated: Bool) {
        configureView()
    }
    
    // MARK: - Private metod
    
    private func configureView() {
        titleListLabel.text = listTitle
        
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
        controller?.selectList = SelectListSegueModel(list: titleListLabel.text ?? "New List >")
        return controller
    }
    
    // MARK: - Table view delegate
    
    @IBAction func unwindToNewReminderTableViewCintroller(_ sender: UIStoryboardSegue) {}
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let myListTableViewController = segue.destination as? MyListTableViewController else {
            return
        }
        if titleTextView.text != "" {
            switch titleListLabel.text {
            case "New List >":
                myListTableViewController.notesManager.addNote(title: titleTextView.text, descriptionNote: descriptionTextView.text, id: myListTableViewController.allListCount, listName: "New")
            case "Education List >":
                myListTableViewController.notesManager.addNote(title: titleTextView.text, descriptionNote: descriptionTextView.text, id: myListTableViewController.allListCount, listName: "Education")
            case "Swift List >":
                myListTableViewController.notesManager.addNote(title: titleTextView.text, descriptionNote: descriptionTextView.text, id: myListTableViewController.allListCount, listName: "Swift Homework")
            case "Podcast List >":
                myListTableViewController.notesManager.addNote(title: titleTextView.text, descriptionNote: descriptionTextView.text, id: myListTableViewController.allListCount, listName: "Podcast")
            case "Books List >":
                myListTableViewController.notesManager.addNote(title: titleTextView.text, descriptionNote: descriptionTextView.text, id: myListTableViewController.allListCount, listName: "Books")
            default:
                break
            }
            myListTableViewController.countListTitle()
        } else {
            dismiss(animated: true)
        }
    }
}
