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
        CoreDataTestsUtil.shared.createInMemoryPersistentStoreContainer(completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let container):
                self.container = container
                self.sut = CoreDataService(container: container)
            case .failure(let error):
                debugPrint("Unable to create container: \(error.localizedDescription)")
            }
        })
    }
    
    override func tearDownWithError() throws {
        CoreDataTestsUtil.shared.deleteAllData(container: container)
        
        sut = nil
        container = nil
    }
    
    func test_loadCarsWithoutPriorSaving_fetchesNoCar() async {
        do {
            let coreDataCars = try await sut.loadCars()
            XCTAssertEqual(coreDataCars.count, 0)
        } catch {
            XCTFail("Failed to load cars from CoreData")
        }
    }
        
    func test_saveCarsThenLoadCars_persistsInCoreData() async {
        let carCount = 4
        let cars = CoreDataTestsUtil.shared.createCars(carCount)
        do {
            try CoreDataService.saveCars(cars, context: sut.container.viewContext)
            let coreDataCars = try await sut.loadCars()
            XCTAssertEqual(coreDataCars.count, carCount)
        } catch {
            XCTFail("Unable to save cars in Core Data")
        }
    }
    
    func test_fetchWrongEntity_resultsInError() async {
        sut = CoreDataService(container: container, entityName: "CDVan")
        do {
            let coreDataCars = try await sut.loadCars()
            XCTFail("Failed to load cars from CoreData")
        } catch {
            XCTAssertEqual(error.localizedDescription, DataError.unableToFetchFromCoreData.localizedDescription
            )
        }
    }
}
