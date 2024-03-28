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
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}
