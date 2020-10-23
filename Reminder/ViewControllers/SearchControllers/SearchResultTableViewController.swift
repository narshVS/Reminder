//
//  SearchTableViewController.swift
//  Reminder
//
//  Created by Влад Овсюк on 28.08.2020.
//  Copyright © 2020 Vlad Ovsyuk. All rights reserved.
//

import UIKit

final class SearchResultTableViewController: UITableViewController {
    
    // MARK: - Private properties
    
    private var resultNote: [List] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - Lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        register()
    }
    
    // MARK: - Public metod
    
    public func set(filteredNote: [List]) {
        self.resultNote = filteredNote
    }
    
    // MARK: - TebleView Register
    
    private func register() {
        tableView.register(UINib(nibName: "SearchCell", bundle: Bundle.main), forCellReuseIdentifier: SearchCell.reusableId)
        tableView.tableFooterView = UIView()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        resultNote.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.reusableId, for: indexPath) as! SearchCell
        cell.configure(titleNoteModel: resultNote[indexPath.row], titleDescriptionModel: resultNote[indexPath.row], titleListModel: resultNote[indexPath.row])
        return cell
    }
}
