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
        sut = FileDataService(filename: "Cars")
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_LoadCarsFromCorrectFile_RetrievesCars() async {
        let cars = try? await sut.loadCars()
        let expectedCount = cars?.count ?? 0
        XCTAssertEqual(expectedCount, 5)
    }
    
    func test_LoadCarsFromNonExistentFile_ReturnsNoFileError() async {
        sut = FileDataService(filename: "NonExistingFile")
        do {
            let _ = try await sut.loadCars()
            XCTFail("load cars is not expected to succeed")
        } catch {
            XCTAssertEqual(error as! DataError, DataError.noFileInBundle)
        }
    }
}
