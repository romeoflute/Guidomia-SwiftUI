//
//  DataServiceProtocol.swift
//  Guidomia-SwiftUI
//
//  Created by Romeo Flauta on 3/27/24.
//

import Foundation

protocol DataFetchService {
    func loadCars() async throws -> [Car]
}
