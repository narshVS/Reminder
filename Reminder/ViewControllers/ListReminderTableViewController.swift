//
//  ListReminderTableViewController.swift
//  Homework 11-13 Ovsyuk
//
//  Created by Влад Овсюк on 06.08.2020.
//  Copyright © 2020 Vlad Ovsyuk. All rights reserved.
//

import UIKit

/// final?
class ListReminderTableViewController: UITableViewController {
    
    // MARK: - Outlets
    
    @IBOutlet var checkBoxCollection: [UIImageView]!
 
    // MARK: - Properties
    
    var selectList: SelectListSegueModel?
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkBoxSet()
    }
    
    // MARK: - Private metod
    
    /// Set visibility checkBox selected list
    private func checkBoxSet() {
        for allCheck in checkBoxCollection {
            allCheck.isHidden = true
        }
        switch selectList?.list {
        case "New List >":
            /// Using incides isn't a good idea. Use safe methods instead to avoid `out of bounds` exception.
            checkBoxCollection[0].isHidden = false
        case "Education List >":
            checkBoxCollection[1].isHidden = false
        case "Swift List >":
            checkBoxCollection[2].isHidden = false
        case "Podcast List >":
            checkBoxCollection[3].isHidden = false
        case "Books List >":
            checkBoxCollection[4].isHidden = false
        default:
            break
        }
    }
    
    /// This method does the opposite stuff to the previous one. Do you really need them both?
    private func unwindListTitle() -> String {
        var title = ""
        if checkBoxCollection[0].isHidden == false {
            title = "New List >"
        } else if checkBoxCollection[1].isHidden == false {
            title =  "Education List >"
        } else if checkBoxCollection[2].isHidden == false {
            title =  "Swift List >"
        } else if checkBoxCollection[3].isHidden == false {
            title =  "Podcast List >"
        } else if checkBoxCollection[4].isHidden == false {
            title =  "Books List >"
        }
        return title
    }
    
    // MARK: - Table view delegate
    
    /// Selecte list
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Hide all checkbox
        for allCheck in checkBoxCollection {
            allCheck.isHidden = true
        }
        
        // Selecte list and unwind segue title list
        switch indexPath.row {
        case 0:
            checkBoxCollection[0].isHidden = false
            performSegue(withIdentifier: "NewReminderUnwindSegue", sender: self)
        case 1:
            checkBoxCollection[1].isHidden = false
            performSegue(withIdentifier: "NewReminderUnwindSegue", sender: self)
        case 2:
            checkBoxCollection[2].isHidden = false
            performSegue(withIdentifier: "NewReminderUnwindSegue", sender: self)
        case 3:
            checkBoxCollection[3].isHidden = false
            performSegue(withIdentifier: "NewReminderUnwindSegue", sender: self)
        case 4:
            checkBoxCollection[4].isHidden = false
            performSegue(withIdentifier: "NewReminderUnwindSegue", sender: self)
        default:
            break
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let newReminderTableViewCintroller = segue.destination as? NewReminderTableViewCintroller else {
            return
        }
        newReminderTableViewCintroller.listTitle = unwindListTitle() // Unwind selecte title list
    }
}
