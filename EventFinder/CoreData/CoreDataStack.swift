//
//  CoreDataStack.swift
//  EventFinder
//
//  Created by Marwan Ait Addi on 05/04/2024.
//

import Foundation
import CoreData

final class CoreDataStack {
    // MARK: - Singleton
    
    static let sharedInstance = CoreDataStack()
    
    // MARK: - private
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name : "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
        if let error = error as NSError? {
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
        })
        return container
    }()
    
    // MARK: - Public

    var viewContext: NSManagedObjectContext {
        return CoreDataStack.sharedInstance.persistentContainer.viewContext
    }
  
}
