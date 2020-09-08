//
//  ReminderListCell.swift
//  Homework 11-13 Ovsyuk
//
//  Created by Влад Овсюк on 09.08.2020.
//  Copyright © 2020 Vlad Ovsyuk. All rights reserved.
//

import UIKit

final class ReminderNoteCell: UITableViewCell {
    
    @IBOutlet weak var titleNoteLabel: UILabel!
    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var circleImageView: UIImageView!
    
    var imageButton = "circle"
    var titleForColor = ""
    var noteTitle = ""
    
    func configure(with titleModel: ReminderNoteModel) {
        titleNoteLabel.text = titleModel.title
    }

    @IBAction func checkBoxTapped(_ sender: Any) {
        if imageButton == "circle" {
            circleImageView.isHidden = false
            imageButton = "circle.fill"
            titleNoteColorSet()
        } else {
            checkBoxButton.tintColor = .placeholderText
            circleImageView.isHidden = true
            imageButton = "circle"
        }
    }
    
   private func titleNoteColorSet() {
        switch noteTitle {
        case "New":
            checkBoxButton.tintColor = .systemGreen
            circleImageView.tintColor = .systemGreen
        case "Education":
            checkBoxButton.tintColor = .systemPink
            circleImageView.tintColor = .systemPink
        case "Swift":
            checkBoxButton.tintColor = .systemIndigo
            circleImageView.tintColor = .systemIndigo
        case "Podcast":
            checkBoxButton.tintColor = .systemPurple
            circleImageView.tintColor = .systemPurple
        case "Books":
            checkBoxButton.tintColor = .systemYellow
            circleImageView.tintColor = .systemYellow
        default:
            break
        }
    }
}
