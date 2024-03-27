//
//  BrowseCarsViewModel.swift
//  Guidomia-SwiftUI
//
//  Created by Romeo Flauta on 3/27/24.
//

import Foundation

@MainActor
final class BrowseCarsViewModel: NSObject, ObservableObject {
    private let dataOrchestrator: DataFetchService
    
    @Published var cars: [Car] = []
    @Published var error: Error? = nil
    
    init(dataOrchestrator: DataFetchService = OrchestrateDataService()) {
        self.dataOrchestrator = dataOrchestrator
    }
    
    func fetchData() async {
        do {
            var cars = try await dataOrchestrator.loadCars()
            
            self.cars = sortCarsByRating(cars, highestRatingOnTop: true)
        } catch {
            self.error = error
        }
    }
    
    func sortCarsByRating(_ cars: [Car], highestRatingOnTop: Bool) -> [Car] {
        return cars.sorted { a, b in
            return highestRatingOnTop ? a.rating > b.rating : a.rating < b.rating
        }
    }
}
