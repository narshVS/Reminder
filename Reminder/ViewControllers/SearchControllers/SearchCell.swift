//
//  SearchCell.swift
//  Homework 11-13 Ovsyuk
//
//  Created by Влад Овсюк on 28.08.2020.
//  Copyright © 2020 Vlad Ovsyuk. All rights reserved.
//

import UIKit

final class SearchCell: UITableViewCell {
    
    // MARK: - Outlet
    
    @IBOutlet weak var titleListLabel: UILabel!
    @IBOutlet weak var titleNoteLabel: UILabel!
    @IBOutlet weak var titleDescriptionLabel: UILabel!
    
    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var checkBoxFillButton: UIButton!
    
    
    // MARK: - Privat properties
    
    private var buttonEnabled = true
    
    // MARK: - Static properties
    
    static let reusableId = "SearchCell"
    
    // MARK: - Properties
    
    var listStorage: RemindeNoteModel?
    
    // MARK: - Configure
    
    /// Better name it `configure(with:desctiptionModel:listModel:)`
    func configure(titleNoteModel: RemindeNoteModel, titleDescriptionModel: RemindeNoteModel, titleListModel: RemindeNoteModel) {
        titleNoteLabel.text = titleNoteModel.title
        titleDescriptionLabel.text = titleDescriptionModel.description
        titleListLabel.text = titleListModel.list
        titleColorSet()
        checkButtonEnable() /// Remove description when it empty and configure him and title list
    }
    
    // MARK: - Action
    
    // Tapped on button and configue vision, color
    @IBAction func checkBoxTapped(_ sender: Any) {
        if buttonEnabled == true {
            checkBoxFillButton.isHidden = false
            buttonEnabled = false
            checkBoxColorSet() // Set color
        } else {
            checkBoxButton.tintColor = .placeholderText
            checkBoxFillButton.isHidden = true
            buttonEnabled = true
        }
    }
    
    // MARK: - Private methods
    
    /// Better name it `setTitleColor()`
    private func titleColorSet() {
        switch listStorage?.list {
        case "New":
            titleListLabel.textColor = .systemGreen
        case "Education":
            titleListLabel.textColor = .systemPink
        case "Swift Homework":
            titleListLabel.textColor = .systemIndigo
        case "Podcast":
            titleListLabel.textColor = .systemPurple
        case "Books":
            titleListLabel.textColor = .systemYellow
        default:
            break
        }
    }
    
    /// Remove description when it empty and configure him and title list
    private func checkButtonEnable() {
        if checkBoxButton.isEnabled == false {
            checkBoxColorSet()
        } else {
            checkBoxButton.tintColor = .placeholderText
            checkBoxFillButton.tintColor = .placeholderText
            checkBoxFillButton.isHidden = true
        }
    }
    
    private func checkBoxColorSet() {
        switch listStorage?.list {
        case "New":
            checkBoxButton.tintColor = .systemGreen
            checkBoxFillButton.tintColor = .systemGreen
        case "Education":
            checkBoxButton.tintColor = .systemPink
            checkBoxFillButton.tintColor = .systemPink
        case "Swift Homework":
            checkBoxButton.tintColor = .systemIndigo
            checkBoxFillButton.tintColor = .systemIndigo
        case "Podcast":
            checkBoxButton.tintColor = .systemPurple
            checkBoxFillButton.tintColor = .systemPurple
        case "Books":
            checkBoxButton.tintColor = .systemYellow
            checkBoxFillButton.tintColor = .systemYellow
        default:
            break
        }
    }
}
