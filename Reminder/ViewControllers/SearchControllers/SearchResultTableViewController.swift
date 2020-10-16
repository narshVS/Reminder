//
//  SearchTableViewController.swift
//  Homework 11-13 Ovsyuk
//
//  Created by Влад Овсюк on 28.08.2020.
//  Copyright © 2020 Vlad Ovsyuk. All rights reserved.
//

import UIKit

final class SearchResultTableViewController: UITableViewController {
    
    // MARK: - Private properties
    
    private var resultNote: [NoteModel] = [] {
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
    
    public func set(filteredNote: [NoteModel]) {
        self.resultNote = filteredNote
        setID()
    }
    
    // MARK: - Private metod
    
    /// Need for set color button
    private func setID() {
        var newId = 0
        var index = 0
        for _ in resultNote {
            resultNote[index].id = newId
            newId += 1
            index += 1
        }
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
        
        // Set colot button
        for index in resultNote {
            if index.id == indexPath.row {
                cell.listStorage = index // set in model
                
            }
        }
        
        cell.configure(titleNoteModel: resultNote[indexPath.row], titleDescriptionModel: resultNote[indexPath.row], titleListModel: resultNote[indexPath.row])
        return cell
    }
}
