//
//  CoreDataStack.swift
//  Reminder
//
//  Created by Влад Овсюк on 20.10.2020.
//  Copyright © 2020 Vlad Ovsyuk. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    private let modelName = "Reminder"
    
    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: modelName)
        container.loadPersistentStores {
            (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    lazy var managedContext: NSManagedObjectContext = {
        return self.storeContainer.viewContext
    }()
    
    func saveContext() {
        guard managedContext.hasChanges else { return }
        do {
            try managedContext.save()
        } catch let error as NSError {
            managedContext.rollback()
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    func deleteContext(object: NSManagedObject) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "List")
        fetchRequest.includesPropertyValues = false
        managedContext.delete(object)
    }
}
