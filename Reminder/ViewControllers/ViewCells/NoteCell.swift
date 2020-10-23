//
//  NoteCell.swift
//  Reminder
//
//  Created by Влад Овсюк on 09.08.2020.
//  Copyright © 2020 Vlad Ovsyuk. All rights reserved.
//

import UIKit

final class NoteCell: UITableViewCell {
    
    // MARK: - Outlet
    
    @IBOutlet weak var titleNoteLabel: UILabel!
    @IBOutlet weak var titleDescriptionLabel: UILabel!
    
    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var checkBoxFillButton: UIButton!
    
    // MARK: - Properties
    
    private var buttonIsEnabled = false
    var list = ""
    
    // MARK: - Configure
    
    func configure(titleNote: List, titleDescriptionModel: List) {
        titleNoteLabel.text = titleNote.title
        discriptionIsEnabled(title: titleDescriptionModel)
    }
    
    // MARK: - Action
    
    /// Tapped on button and configue vision, color
    @IBAction func checkBoxTapped(_ sender: Any) {
        if buttonIsEnabled == true {
            checkBoxButton.tintColor = .placeholderText
            checkBoxFillButton.isHidden = true
            buttonIsEnabled = false
        } else {
            checkBoxFillButton.isHidden = false
            buttonIsEnabled = true
            buttonColorSet() // Set color
        }
    }
    
    // MARK: - Privat metod
    
    /// Set color button
    private func buttonColorSet() {
        switch list {
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
    
    /// Remove description when it empty and configure him
    private func discriptionIsEnabled(title: List) {
        if title.description != "" {
            titleDescriptionLabel?.text = title.descriptionNote
        } else {
            titleDescriptionLabel?.removeFromSuperview()
        }
    }
}
