//
//  OrchestrateDataService.swift
//  Guidomia-SwiftUI
//
//  Created by Romeo Flauta on 3/27/24.
//

import Foundation

final class OrchestrateDataService: DataFetchService, ObservableObject {
    let fileDatabaseService = FileDataService()
    let localDatabaseService = CoreDataService()
    
    @Published var cars: [Car] = []
    
    func loadCars() async throws -> [Car] {
        do {
            let carsFromCoreData = try await localDatabaseService.loadCars()
            if carsFromCoreData.count > 0 {
                return carsFromCoreData
            } else {
                let carsFromFile = try await fileDatabaseService.loadCars()
                return carsFromFile
            }
        } catch {
            throw error
        }
    }
}
