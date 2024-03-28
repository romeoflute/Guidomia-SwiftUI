//
//  BrowseCarsViewModelTests.swift
//  Guidomia-SwiftUITests
//
//  Created by Romeo Flauta on 3/28/24.
//

import XCTest
import CoreData
@testable import Guidomia_SwiftUI

final class BrowseCarsViewModelTests: XCTestCase {
    
    var sut: BrowseCarsViewModel!
    var fileDatabaseService: FileDataService!
    var localDatabaseService: CoreDataService!
    var orchestrator: OrchestrateDataService!
    var container: NSPersistentContainer!

    @MainActor override func setUp() async throws {
        CoreDataTestsUtil.shared.createInMemoryPersistentStoreContainer(completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let container):
                self.container = container
                self.localDatabaseService = CoreDataService(container: container)
                self.orchestrator = OrchestrateDataService(localDatabaseService: self.localDatabaseService)
                self.sut = BrowseCarsViewModel(dataOrchestrator: orchestrator)
            case .failure(_):
                debugPrint("Unable to create container")
            }
        })
    }

    override func tearDownWithError() throws {
        CoreDataTestsUtil.shared.deleteAllData(container: container)
        
        container = nil
        fileDatabaseService = nil
        localDatabaseService = nil
        orchestrator = nil
        sut = nil
    }

    @MainActor func test_loadCarsFromViewModel_fillsCarsVariables() async {
        await sut.fetchData()
        
        XCTAssertEqual(sut.featuredCars.count, 1)
        XCTAssertEqual(sut.listCars.count, 4)
        XCTAssertNotNil(sut.selectedCar)
        XCTAssertEqual(sut.selectedCar?.model, sut.listCars.first?.model)
        XCTAssertNil(sut.error)
        XCTAssertEqual(sut.makeFilter, "")
        XCTAssertEqual(sut.modelFilter, "")
    }
}
