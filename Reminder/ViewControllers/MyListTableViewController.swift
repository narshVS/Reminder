//
//  MyListTableViewController.swift
//  Reminder
//
//  Created by Влад Овсюк on 04.08.2020.
//  Copyright © 2020 Vlad Ovsyuk. All rights reserved.
//

import UIKit 

final class MyListTableViewController: UITableViewController, UISearchBarDelegate, UISearchControllerDelegate {
    
    // MARK: - Search Controller
    
    private var searchResultController: SearchResultTableViewController?
    private var filteredNotes = [NoteModel]()
    private var allNotes: [NoteModel] = [] // The array is needed for searching
    
    /// Customization search сontroller
    private func configureSearchController() {
        searchResultController = SearchResultTableViewController()
        let searchController = UISearchController(searchResultsController: searchResultController)
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        searchController.delegate = self
        searchController.searchBar.placeholder = "Search"
    }
    
    // MARK: - Outlet

    @IBOutlet weak var newCountLabel: UILabel!
    @IBOutlet weak var educationCountLabel: UILabel!
    @IBOutlet weak var swiftHomeworkLabel: UILabel!
    @IBOutlet weak var podcastCountLabel: UILabel!
    @IBOutlet weak var booksCountLabel: UILabel!
    
    
    // MARK: - Private properties
    
    private var selectedCell: UITableViewCell?
    
    // MARK: - List Note
    
    var newList: [NoteModel] = [
        NoteModel(id: 0, list: "New", title: "Test", description: "Test"),
        NoteModel(id: 1, list: "New", title: "Test ", description: "")]
    
    var educationList: [NoteModel] = [
        NoteModel(id: 0, list: "Education",  title: "Test", description: "")]
    
    var swiftHomeworkList: [NoteModel] = [
        NoteModel(id: 0, list: "Swift Homework",  title: "Create Reminder", description: ""),
        NoteModel(id: 1, list: "Swift Homework",  title: "Test", description: "")]
    
    var podcastList: [NoteModel] = []
    
    var booksList: [NoteModel] = [
        NoteModel(id: 0, list: "Books",  title: "Прочесть 'Выбор великого демона'", description: ""),
        NoteModel(id: 1, list: "Books",  title: "Прочесть 'Черное пламя над степью'", description: "Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test")]
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        countListTitle()
        setDefaultTitle()
    }
    
    // MARK: - Public metod
    
    func countListTitle() {
        newCountLabel.text = "\(newList.count) >"
        educationCountLabel.text = "\(educationList.count) >"
        swiftHomeworkLabel.text = "\(swiftHomeworkList.count) >"
        podcastCountLabel.text = "\(podcastList.count) >"
        booksCountLabel.text = "\(booksList.count) >"
        navigationController?.toolbar.isHidden = false
    }
    
    // MARK: - Private metod
    
    private func appendAllList() {
        allNotes = []
        allNotes.append(contentsOf: newList)
        allNotes.append(contentsOf: educationList)
        allNotes.append(contentsOf: swiftHomeworkList)
        allNotes.append(contentsOf: podcastList)
        allNotes.append(contentsOf: booksList)
    }
    
    /// Better name it `showToolbar()`
    private func unHideToolbar() {
        self.navigationController?.setToolbarHidden(false, animated: true)
    }
    
    private func hideToolbar() {
        self.navigationController?.setToolbarHidden(true, animated: true)
    }
    
    private func setDefaultTitle() {
        navigationController?.navigationBar.largeTitleTextAttributes = [ NSAttributedString.Key.foregroundColor: UIColor.label]
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCell = tableView.cellForRow(at: indexPath)
        performSegue(withIdentifier: "selectedListSegue", sender: self)
    }
    
    @IBSegueAction func cellTapped(_ coder: NSCoder) -> SelectedListTableViewController? {
        let controller = SelectedListTableViewController(coder: coder)
        switch selectedCell?.textLabel?.text {
        case "New":
            controller?.listSegueModel = ListSegueModel(title: "New", listNoteArray: newList)
        case "Education":
            controller?.listSegueModel = ListSegueModel(title: "Education", listNoteArray: educationList)
        case "Swift Homework":
            controller?.listSegueModel = ListSegueModel(title: "Swift Homework", listNoteArray: swiftHomeworkList)
        case "Podcast":
            controller?.listSegueModel = ListSegueModel(title: "Podcast", listNoteArray: podcastList)
        case "Books":
            controller?.listSegueModel = ListSegueModel(title: "Books", listNoteArray: booksList)
        default:
            break
        }
        return controller
    }
    
    @IBAction func unwindToMyListTableViewController(_ sender: UIStoryboardSegue) {}
}

extension MyListTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let queryText = searchController.searchBar.text else {
            return
        }
        appendAllList()
        if queryText.isEmpty {
            filteredNotes = allNotes
        } else {
            filteredNotes = []
            allNotes.forEach { model in
                if model.title.contains(queryText) {
                    filteredNotes.append(model)
                }
            }
        }
        searchResultController?.set(filteredNote: filteredNotes)
    }
    
    /// Methods show/hide toolbar for search
    func willPresentSearchController(_ searchController: UISearchController) {
        hideToolbar()
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        unHideToolbar()
    }
}
