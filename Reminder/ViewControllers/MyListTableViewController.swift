//
//  MyListTableViewController.swift
//  Homework 11-13 Ovsyuk
//
//  Created by Влад Овсюк on 04.08.2020.
//  Copyright © 2020 Vlad Ovsyuk. All rights reserved.
//

import UIKit 

/// final?
class MyListTableViewController: UITableViewController, UISearchBarDelegate, UISearchControllerDelegate {
    
    // MARK: - Outlet
    
    @IBOutlet weak var newCountLabel: UILabel!
    @IBOutlet weak var educationCountLabel: UILabel!
    @IBOutlet weak var swiftHomeworkLabel: UILabel!
    @IBOutlet weak var podcastCountLabel: UILabel!
    @IBOutlet weak var booksCountLabel: UILabel!
    
    // MARK: - Private properties
    
    private var selectedCell: UITableViewCell?
    
    // MARK: - List Note
    
    /// Don't initialize models inside the VC. Move it elsewhere.
    var newList: [RemindeNoteModel] = [
        RemindeNoteModel(id: 0, list: "New", title: "Test", description: "Test"),
        RemindeNoteModel(id: 0, list: "New", title: "Test ", description: "")]
    
    var educationList: [RemindeNoteModel] = [
        RemindeNoteModel(id: 0, list: "Education",  title: "Test", description: "")]
    
    var swiftHomeworkList: [RemindeNoteModel] = [
        RemindeNoteModel(id: 0, list: "Swift Homework",  title: "Create Reminder", description: ""),
        RemindeNoteModel(id: 1, list: "Swift Homework",  title: "Test", description: "")]
    
    var podcastList: [RemindeNoteModel] = []
    
    var booksList: [RemindeNoteModel] = [
        RemindeNoteModel(id: 0, list: "Books",  title: "Прочесть 'Выбор великого демона'", description: ""),
        RemindeNoteModel(id: 1, list: "Books",  title: "Прочесть 'Черное пламя над степью'", description: "Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test")]
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchControllerConfigure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        countListTitle()
    }
    
    // MARK: - Search Controller
    
    /// Don't mix properties with methods. Better define them grouped at the beginning of the class definition.
    private var searchResultController: SearchResultTableViewController?
    /// notes*
    private var filteredNote = [RemindeNoteModel]()
    /// Better name it `originalNotes`.
    private var allList: [RemindeNoteModel] = [] // The array is needed for searching
    
    /// Customization search сontroller
    /// Better name the method as a command or call to action starting with a verb.
    /// E.g. `configureSearchController()`
    private func searchControllerConfigure() {
        searchResultController = SearchResultTableViewController()
        let searchController = UISearchController(searchResultsController: searchResultController)
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        searchController.delegate = self
        searchController.searchBar.placeholder = "Search"
    }
    
    // MARK: - Private metod
    
    private func countListTitle() {
        newCountLabel.text = "\(newList.count) >"
        educationCountLabel.text = "\(educationList.count) >"
        swiftHomeworkLabel.text = "\(swiftHomeworkList.count) >"
        podcastCountLabel.text = "\(podcastList.count) >"
        booksCountLabel.text = "\(booksList.count) >"
        navigationController?.toolbar.isHidden = false
    }
    
    /// append*
    private func appedAllList() {
        allList = []
        allList.append(contentsOf: newList)
        allList.append(contentsOf: educationList)
        allList.append(contentsOf: swiftHomeworkList)
        allList.append(contentsOf: podcastList)
        allList.append(contentsOf: booksList)
    }
    
    /// Better name it `showToolbar()`
    private func unHideToolbar() {
        self.navigationController?.setToolbarHidden(false, animated: true)
    }
    
    private func hideToolbar() {
        self.navigationController?.setToolbarHidden(true, animated: true)
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
    
    /// Don't leave empty methods in the code.
    @IBAction func unwindToMyListTableViewController(_ sender: UIStoryboardSegue) {}
}

extension MyListTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let queryText = searchController.searchBar.text else {
            return
        }
        appedAllList()
        if queryText.isEmpty {
            filteredNote = allList
        } else {
            filteredNote = []
            allList.forEach { model in
                if model.title.contains(queryText) {
                    filteredNote.append(model)
                }
            }
        }
        searchResultController?.set(filteredNote: filteredNote)
    }
    
    /// Methods show/hide toolbar for search
    func willPresentSearchController(_ searchController: UISearchController) {
        hideToolbar()
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        unHideToolbar()
    }
}
