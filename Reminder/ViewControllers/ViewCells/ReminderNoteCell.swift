//
//  ReminderNoteCell.swift
//  Homework 11-13 Ovsyuk
//
//  Created by Влад Овсюк on 09.08.2020.
//  Copyright © 2020 Vlad Ovsyuk. All rights reserved.
//

import UIKit

final class ReminderNoteCell: UITableViewCell {
    
    // MARK: - Outlet
    
    @IBOutlet weak var titleNoteLabel: UILabel!
    @IBOutlet weak var titleDescriptionLabel: UILabel!
    
    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var checkBoxFillButton: UIButton!
    
    // MARK: - Properties
    
    /// private?
    var buttonIsEnabled = false
    var list = ""
    
    // MARK: - Configure
    
    /// Better name the method `configure(with:descriptionModel:)`
    func configure(titleNoteModel: RemindeNoteModel, titleDescriptionModel: RemindeNoteModel) {
        titleNoteLabel.text = titleNoteModel.title
        discriptionIsEnabled(title: titleDescriptionModel)
    }
    
    // MARK: - Action
    
    /// Tapped on button and configue vision, color
    @IBAction func checkBoxTapped(_ sender: Any) {
        /// Better write if-else blocks starting from the `true` condition to adopt the human readable logic.
        /// E.g.:
        /// if buttonIsEnabled {
        ///     ...
        /// } else { // Here we expect that the condition is false.
        ///     ...
        /// }
        if buttonIsEnabled == false {
            checkBoxFillButton.isHidden = false
            buttonIsEnabled = true
            buttonColorSet() // Set color
        } else {
            checkBoxButton.tintColor = .placeholderText
            checkBoxFillButton.isHidden = true
            buttonIsEnabled = false
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
    private func discriptionIsEnabled(title: RemindeNoteModel) {
        /// Why don't using `.isEmpty`?
        if title.description != "" {
            titleDescriptionLabel?.text = title.description
        } else {
            titleDescriptionLabel?.removeFromSuperview()
        }
    }
}
