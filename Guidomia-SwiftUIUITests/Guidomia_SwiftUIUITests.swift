//
//  Guidomia_SwiftUIUITests.swift
//  Guidomia-SwiftUIUITests
//
//  Created by Romeo Flauta on 3/29/24.
//

import XCTest

final class Guidomia_SwiftUIUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launch()
        
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func test_AppName_exits() throws {
        let appName = app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"].staticTexts["appName"]
        
        XCTAssertTrue(appName.exists)
    }

    func test_onLaunch_firstRowIsExpanded() throws {
        let pros = app.collectionViews.staticTexts["Pros :"].firstMatch
        
        XCTAssertTrue(pros.exists)
        XCTAssertEqual(pros.identifier, "Roadster")
    }
    
    func test_tappingTheSecondRow_expandsSecondRowAndCompactsFirstRow() throws {
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery.images["Alpine"].firstMatch.swipeUp()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.images["RangeRover"]/*[[".cells.images[\"RangeRover\"]",".images[\"RangeRover\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.firstMatch.swipeUp()
        
        let allPros = app.otherElements.children(matching: .staticText).matching(identifier: "Pros :")
        
        let pros = allPros.firstMatch
        
        // There is only one expanded
        XCTAssertEqual(allPros.count, 1)
        // It is the Roadster row
        XCTAssertEqual(pros.identifier, "Roadster")
        
        XCUIApplication().collectionViews/*@START_MENU_TOKEN@*/.images["RangeRover"]/*[[".cells.images[\"RangeRover\"]",".images[\"RangeRover\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        // There is only one expanded
        XCTAssertEqual(allPros.count, 1)
        // It is the Range Rover row
        XCTAssertEqual(pros.identifier, "Range Rover")
    }
    
    func test_filterMake_returnsFilteredList() {
        let anyMakeTextField = app.collectionViews.textFields["Any make"].firstMatch
        
        XCTAssert(anyMakeTextField.exists)
        anyMakeTextField.tap()
        anyMakeTextField.typeText("M")
        
        let bmw = app.otherElements.children(matching: .staticText).matching(identifier: "BMW 3300i").firstMatch
        
        let mercedez = app.otherElements.children(matching: .staticText).matching(identifier: "Mercedes Benz").firstMatch
        
        let roadster = app.otherElements.children(matching: .staticText).matching(identifier: "Alpine Roadster").firstMatch
        
        XCTAssert(bmw.exists)
        XCTAssert(mercedez.exists)
        XCTAssertFalse(roadster.exists)
    }
}
