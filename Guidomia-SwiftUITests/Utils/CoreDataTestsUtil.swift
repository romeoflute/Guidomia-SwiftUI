//
//  CoreDataTestsUtil.swift
//  Guidomia-SwiftUITests
//
//  Created by Romeo Flauta on 3/28/24.
//

import Foundation
import CoreData
@testable import Guidomia_SwiftUI

final class CoreDataTestsUtil {
    static let shared = CoreDataTestsUtil()
    
    private init() {}
    
    // Mark: - Helpers
    
    /// Use an in-memory container for testing
    func createInMemoryPersistentStoreContainer(completion: @escaping (Result<NSPersistentContainer, Error>) -> Void) {
        let description = NSPersistentStoreDescription()
        description.url = URL(fileURLWithPath: "/dev/null")
        let container = NSPersistentContainer(name: "Cars")
        container.persistentStoreDescriptions = [description]
        
        container.loadPersistentStores { _, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(container))
            }
        }
    }
    
    func createCars(_ number: Int) -> [Car] {
        var cars: [Car] = []
        guard number > 0 else { return [] }
        for i in 1...number {
            cars.append(Car(consList: ["one con", "two con"], customerPrice: Double(i) * 500, make: "Make\(i)", marketPrice: Double(i) * 500, model: "Model\(i)", prosList: ["one pro", "two pro"], rating: i, imageName: "Image\(i)", isFeatured: false))
        }
        return cars
    }
    
    func deleteAllData(container: NSPersistentContainer) {
        // Get a reference to a NSPersistentStoreCoordinator
        let coordinator = container.persistentStoreCoordinator
        for store in coordinator.persistentStores {
            guard let url = store.url else { continue }
            
            try? coordinator.destroyPersistentStore(at: url, ofType: store.type)
        }
    }
}
