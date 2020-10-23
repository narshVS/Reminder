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
    private var filteredNotes = [List]()
    private var allNotes = [List]() // The array is needed for searching
    
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
    
    // MARK: - Properties
    
    var notesManager = NotesManager()
    
    var newListCount: Int = 0
    var educationListCount: Int = 0
    var swiftHomeworkListCount: Int = 0
    var podcastListCount: Int = 0
    var booksListCount: Int = 0
    var allListCount: Int = 0
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        countListTitle()
    }
    
    // MARK: - Public metod
    
    func countListTitle() {
        newListCount = 0
        educationListCount = 0
        swiftHomeworkListCount = 0
        podcastListCount = 0
        booksListCount = 0
        allListCount = 0
        
        notesManager.fetchGroups { [weak self] notes in
            notes.forEach {
                switch $0.listName {
                case "New":
                    self?.newListCount += 1
                    self?.allListCount += 1
                case "Education":
                    self?.educationListCount += 1
                    self?.allListCount += 1
                case "Swift Homework":
                    self?.swiftHomeworkListCount += 1
                    self?.allListCount += 1
                case "Podcast":
                    self?.podcastListCount += 1
                    self?.allListCount += 1
                case "Books":
                    self?.booksListCount += 1
                    self?.allListCount += 1
                default:
                    break
                }
            }
        }
        
        newCountLabel.text = "\(newListCount) >"
        educationCountLabel.text = "\(educationListCount) >"
        swiftHomeworkLabel.text = "\(swiftHomeworkListCount) >"
        podcastCountLabel.text = "\(podcastListCount) >"
        booksCountLabel.text = "\(booksListCount) >"
    }
    
    // MARK: - Private metod
    
    private func appendAllList() {
        notesManager.fetchGroups { [weak self] notes in
            self?.allNotes = notes
        }
    }
    
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
            controller?.listTitle = "New"
        case "Education":
            controller?.listTitle = "Education"
        case "Swift Homework":
            controller?.listTitle = "Swift Homework"
        case "Podcast":
            controller?.listTitle = "Podcast"
        case "Books":
            controller?.listTitle = "Books"
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
            allNotes.forEach {
                if $0.title?.contains(queryText) ?? false {
                    filteredNotes.append($0)
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
