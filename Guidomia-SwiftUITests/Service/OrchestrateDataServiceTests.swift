//
//  OrchestrateDataServiceTests.swift
//  Guidomia-SwiftUITests
//
//  Created by Romeo Flauta on 3/28/24.
//

import XCTest
import CoreData
@testable import Guidomia_SwiftUI

final class OrchestrateDataServiceTests: XCTestCase {
    
    var fileDatabaseService: FileDataService!
    var localDatabaseService: CoreDataService!
    var sut: OrchestrateDataService!
    var container: NSPersistentContainer!

    override func setUpWithError() throws {
        CoreDataTestsUtil.shared.createInMemoryPersistentStoreContainer(completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let container):
                self.container = container
                self.localDatabaseService = CoreDataService(container: container)
                self.sut = OrchestrateDataService(localDatabaseService: self.localDatabaseService)
            case .failure(let error):
                debugPrint("Unable to create container")
            }
        })
    }

    override func tearDownWithError() throws {
        CoreDataTestsUtil.shared.deleteAllData(container: container)
        
        sut = nil
        container = nil
        fileDatabaseService = nil
        localDatabaseService = nil
    }
    
    func test_loadCarsFromCoreDataWithoutPriorSaving_fetchesNoCar() async {
        do {
            let coreDataCars = try await sut.localDatabaseService.loadCars()
            XCTAssertEqual(coreDataCars.count, 0)
        } catch {
            XCTFail("Failed to load cars from CoreData")
        }
    }
    
    func test_loadCarsFromOrchestrate_fetchesCarsInFile() async {
        do {
            let orchestrateCars = try await sut.loadCars()
            XCTAssertEqual(orchestrateCars.count, 5)
        } catch {
            XCTFail("Failed to load cars from Orchestrate")
        }
    }
    
    func test_loadCarsFromCoreDataAfterLoadCarsFromOrchestrate_fetchesCarsInCoreData() async {
        do {
            let orchestrateCars = try await sut.loadCars()
            XCTAssertEqual(orchestrateCars.count, 5)
            
            let coreDataCars = try await sut.localDatabaseService.loadCars()
            XCTAssertEqual(coreDataCars.count, 5)
            XCTAssertEqual(coreDataCars.count, orchestrateCars.count)
        } catch {
            XCTFail("Failed to load cars from CoreData or Orchestrate")
        }
    }
}
