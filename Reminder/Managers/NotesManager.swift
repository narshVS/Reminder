//
//  NotesManager.swift
//  Reminder
//
//  Created by Влад Овсюк on 20.10.2020.
//  Copyright © 2020 Vlad Ovsyuk. All rights reserved.
//

import Foundation
import CoreData

final class NotesManager {
    private var coreDataStack = CoreDataStack()
    
    func fetchGroups(completion: @escaping ([List]) -> Void) {
        let listFetch: NSFetchRequest<List> = List.fetchRequest()
        do {
            let List = try coreDataStack.managedContext.fetch(listFetch)
            completion(List)
        } catch let error as NSError {
            print("Fetch error: \(error). Description: \(error.userInfo)")
            completion([])
        }
    }
    
    func addNote(title: String, descriptionNote: String, id: Int, listName: String) {
        let note = List(context: coreDataStack.managedContext)
        note.title = title
        note.descriptionNote = descriptionNote
        note.id = Int64(id)
        note.listName = listName
        coreDataStack.saveContext()
    }
    
    func deleteNote(object: NSManagedObject) {
        coreDataStack.deleteContext(object: object)
        coreDataStack.saveContext()
    }
}
