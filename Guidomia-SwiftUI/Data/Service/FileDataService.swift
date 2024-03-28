//
//  DataService.swift
//  Guidomia-SwiftUI
//
//  Created by Romeo Flauta on 3/27/24.
//

import SwiftUI

final class FileDataService: DataFetchService {
    let filename: String
    
    init(filename: String = "Cars") {
        self.filename = filename
    }
    
    func loadCars() async throws -> [Car] {
        guard let file = Bundle.main.path(forResource: filename, ofType: "json")
        else {
            throw DataError.noFileInBundle
        }
        
        do {
            guard let data = try String(contentsOfFile: file).data(using: .utf8) else {
                throw DataError.noDataInFileFromBundle
            }
            let decoder = JSONDecoder()

            guard let cars = try? decoder.decode([Car].self, from: data) else {
                return []
            }
            return cars
        } catch {
            throw DataError.unparsableJsonFile
        }
    }
}
