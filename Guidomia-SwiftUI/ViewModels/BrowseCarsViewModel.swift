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
    
    @Published var selectedCar: Car? = nil
    @Published var listCars: [Car] = []
    @Published var featuredCars: [Car] = []
    @Published var error: Error? = nil
    
    init(dataOrchestrator: DataFetchService = OrchestrateDataService()) {
        self.dataOrchestrator = dataOrchestrator
    }
    
    func fetchData() async {
        do {
            let cars = try await dataOrchestrator.loadCars()
            let listCars = cars.filter { !$0.isFeatured }
            let featuredCars = cars.filter { $0.isFeatured }
            self.featuredCars = sortCarsByPrice(featuredCars, highestOnTop: true)
            self.listCars = sortCarsByPrice(listCars, highestOnTop: true)
        } catch {
            self.error = error
        }
    }
    
    func sortCarsByPrice(_ cars: [Car], highestOnTop: Bool) -> [Car] {
        return cars.sorted { a, b in
            return highestOnTop ? a.customerPrice > b.customerPrice : a.customerPrice < b.customerPrice
        }
    }
}
