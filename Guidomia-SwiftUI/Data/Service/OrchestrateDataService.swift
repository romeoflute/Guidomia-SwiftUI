//
//  OrchestrateDataService.swift
//  Guidomia-SwiftUI
//
//  Created by Romeo Flauta on 3/27/24.
//

import Foundation
import CoreData

final class OrchestrateDataService: DataFetchService {
    let fileDatabaseService = FileDataService()
    let localDatabaseService = CoreDataService()
        
    func loadCars() async throws -> [Car] {
        let context: NSManagedObjectContext = localDatabaseService.container.viewContext
        do {
            let carsFromCoreData = try await localDatabaseService.loadCars()
            if carsFromCoreData.count > 0 {
                return carsFromCoreData
            } else {
                let carsFromFile = try await fileDatabaseService.loadCars()
                try CoreDataService.saveCars(carsFromFile, context: context)
                return carsFromFile
            }
        } catch {
            throw error
        }
    }
}
