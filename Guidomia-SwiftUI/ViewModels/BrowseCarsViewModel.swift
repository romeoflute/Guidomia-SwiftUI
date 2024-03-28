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
    @Published var makeFilter: String = ""
    @Published var modelFilter: String = ""
    
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
            if self.listCars.count > 0 {
                self.selectedCar = self.listCars.first
            }
        } catch {
            self.error = error
        }
    }
    
    func sortCarsByPrice(_ cars: [Car], highestOnTop: Bool) -> [Car] {
        return cars.sorted { a, b in
            return highestOnTop ? a.customerPrice > b.customerPrice : a.customerPrice < b.customerPrice
        }
    }
    
    func filterListedCars() -> [Car] {
        let makeFilterString = makeFilter.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let modelFilterString = modelFilter.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        
        if makeFilterString == "" && modelFilterString == "" {
            return listCars
        } else if makeFilterString == "" && modelFilterString.count > 0 {
            return listCars.filter { $0.model.lowercased().contains(modelFilterString)}
        } else if makeFilterString.count > 0 && modelFilterString == "" {
            return listCars.filter { $0.make.lowercased().contains(makeFilterString)}
        } else {
            return listCars.filter { $0.make.lowercased().contains(makeFilterString) || $0.model.lowercased().contains(modelFilterString) }
        }
    }
}
