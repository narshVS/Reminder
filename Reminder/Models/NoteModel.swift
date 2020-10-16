//
//  NoteModel.swift
//  Reminder
//
//  Created by Влад Овсюк on 06.08.2020.
//  Copyright © 2020 Vlad Ovsyuk. All rights reserved.
//

import Foundation

struct NoteModel {
    var id: Int // Need Var for rewriting in search controller
    let list: String
    let title: String
    let description: String
}
