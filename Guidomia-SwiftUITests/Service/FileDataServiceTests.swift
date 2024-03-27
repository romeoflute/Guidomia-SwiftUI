//
//  FileDataServiceTests.swift
//  Guidomia-SwiftUITests
//
//  Created by Romeo Flauta on 3/28/24.
//

import XCTest
@testable import Guidomia_SwiftUI

final class FileDataServiceTests: XCTestCase {

    var sut: DataFetchService!
    
    override func setUpWithError() throws {
        sut = FileDataService()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoadCars() async throws {
        let cars = try await sut.loadCars()
        let expectedCount = cars.count
        XCTAssertEqual(expectedCount, 5)
    }
}
