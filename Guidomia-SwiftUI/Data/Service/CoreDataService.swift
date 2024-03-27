//
//  CoreDataService.swift
//  Guidomia-SwiftUI
//
//  Created by Romeo Flauta on 3/27/24.
//

import Foundation
import CoreData

final class CoreDataService: DataSaveService, DataFetchService {
    let container: NSPersistentContainer = NSPersistentContainer(name: "Cars")
    
    /// Default init method. Load the Core Data container
    init() {
        container.loadPersistentStores { _, _ in }
    }
    
    /// Implements DataSaveService to save cars to core data
    func saveCars(_ cars: [Car]) throws {
        let _ = Car.convertToCDCars(cars, context: container.viewContext)
        do {
            try container.viewContext.save()
        } catch {
            throw DataError.unableToSaveInCoreData
        }
    }
    
    /// Implements DataFetchService to fetch cars from core data
    func loadCars() async throws -> [Car] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDCar")
        let context = container.viewContext
        do {
            let request = CDCar.fetchRequest()
            
            let cdCars: [CDCar] = try context.fetch(fetchRequest) as? [CDCar] ?? []
            return Car.convertFromCDCars(cdCars)
        } catch {
            debugPrint("error in Orchestrate? \(error.localizedDescription)")
            throw DataError.unableToFetchFromCoreData
        }
    }
}
