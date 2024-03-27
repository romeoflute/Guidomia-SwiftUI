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
            let cars = try await dataOrchestrator.loadCars()
            
            self.cars = sortCarsByPrice(cars, highestOnTop: true)
            debugPrint("sorted cars: \(self.cars)")
        } catch {
            self.error = error
        }
    }
    
    func featureTopRated() -> Car? {
        return cars.first
    }
    
    func sortCarsByPrice(_ cars: [Car], highestOnTop: Bool) -> [Car] {
        return cars.sorted { a, b in
            return highestOnTop ? a.customerPrice > b.customerPrice : a.customerPrice < b.customerPrice
        }
    }
}
