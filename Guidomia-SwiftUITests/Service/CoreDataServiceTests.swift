//
//  CoreDataServiceTests.swift
//  Guidomia-SwiftUITests
//
//  Created by Romeo Flauta on 3/28/24.
//

import XCTest
@testable import Guidomia_SwiftUI
import CoreData

final class CoreDataServiceTests: XCTestCase {
    
    var sut: CoreDataService!
    var container: NSPersistentContainer!
    
    override func setUpWithError() throws {
        container = createInMemoryPersistentStoreContainer()
        sut = CoreDataService(container: container)
    }
    
    override func tearDownWithError() throws {
        deleteAllData()
        
        sut = nil
        container = nil
    }
    
    func test_saveCarsAndLoadCars_persistsInCoreData() async {
        let carCount = 4
        let cars = createCars(carCount)
        do {
            try CoreDataService.saveCars(cars, context: sut.container.viewContext)
            let coreDataCars = try await sut.loadCars()
            XCTAssertEqual(coreDataCars.count, carCount)
        } catch {
            XCTFail("Unable to save cars in Core Data")
        }
        
    }
    
    // Mark: - Helpers
    
    /// Use an in-memory container for testing
    private func createInMemoryPersistentStoreContainer() -> NSPersistentContainer {
        let description = NSPersistentStoreDescription()
        description.url = URL(fileURLWithPath: "/dev/null")
        let container = NSPersistentContainer(name: "Cars")
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                XCTFail("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }
    
    private func createCars(_ number: Int) -> [Car] {
        var cars: [Car] = []
        guard number > 0 else { return [] }
        for i in 1...number {
            cars.append(Car(consList: ["one con", "two con"], customerPrice: Double(i) * 500, make: "Make\(i)", marketPrice: Double(i) * 500, model: "Model\(i)", prosList: ["one pro", "two pro"], rating: i, imageName: "Image\(i)", isFeatured: false))
        }
        return cars
    }
    
    private func deleteAllData() {
        // Get a reference to a NSPersistentStoreCoordinator
        let coordinator = container.persistentStoreCoordinator
        for store in coordinator.persistentStores {
            guard let url = store.url else { continue }
            
            try? coordinator.destroyPersistentStore(at: url, ofType: store.type)
        }
    }
}
