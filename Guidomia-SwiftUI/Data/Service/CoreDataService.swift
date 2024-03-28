//
//  CoreDataService.swift
//  Guidomia-SwiftUI
//
//  Created by Romeo Flauta on 3/27/24.
//

import Foundation
import CoreData

final class CoreDataService: DataFetchService {
    let container: NSPersistentContainer
    let entityName: String
    
    /// Default init method. Load the Core Data container
    init(container: NSPersistentContainer = NSPersistentContainer(name: "Cars"), entityName: String = "CDCar") {
        self.container = container
        self.entityName = entityName
        self.container.loadPersistentStores { _, _ in }
    }
    
    /// Implements DataFetchService to fetch cars from core data
    func loadCars() async throws -> [Car] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let context = container.viewContext
        do {
            guard container.managedObjectModel.entitiesByName[entityName] != nil else {
                throw DataError.unableToFetchFromCoreData
            }
            let cdCars: [CDCar] = try context.fetch(fetchRequest) as? [CDCar] ?? []
            debugPrint("cd cars: \(cdCars)")
            return Car.convertFromCDCars(cdCars)
        } catch {
            debugPrint("error in Orchestrate? \(error.localizedDescription)")
            throw DataError.unableToFetchFromCoreData
        }
    }
}

extension CoreDataService: DataSaveService {
    /// Implements DataSaveService to save cars to core data
    static func saveCars(_ cars: [Car], context: NSManagedObjectContext) throws {
        let cdCars = Car.convertToCDCars(cars, context: context)
        debugPrint("cdCars: \(cdCars)")
        do {
            try context.save()
        } catch {
            debugPrint("error in saveCars() \(error.localizedDescription)")
            throw DataError.unableToSaveInCoreData
        }
    }
}
