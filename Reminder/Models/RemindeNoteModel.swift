//
//  RemindeNoteModel.swift
//  Homework 11-13 Ovsyuk
//
//  Created by Влад Овсюк on 06.08.2020.
//  Copyright © 2020 Vlad Ovsyuk. All rights reserved.
//

import Foundation

struct RemindeNoteModel {
    /// Does it make sense to change the id anywhere in the model lifecycle?
    var id: Int // Need Var for rewriting in search controller
    let list: String
    let title: String
    let description: String
}
