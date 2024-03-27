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
            let car = try await dataOrchestrator.loadCars()
            self.cars = car
        } catch {
            self.error = error
        }
    }    
}
