//
//  CoreDataService.swift
//  Guidomia-SwiftUI
//
//  Created by Romeo Flauta on 3/27/24.
//

import Foundation
import CoreData

final class CoreDataService: DataFetchService {
    let container: NSPersistentContainer = NSPersistentContainer(name: "Cars")
    
    /// Default init method. Load the Core Data container
    init() {
        container.loadPersistentStores { _, _ in }
    }
    
    /// Implements DataFetchService to fetch cars from core data
    func loadCars() async throws -> [Car] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDCar")
        let context = container.viewContext
        do {
            let cdCars: [CDCar] = try context.fetch(fetchRequest) as? [CDCar] ?? []
            debugPrint("cd cars: \(cdCars.count)")
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
