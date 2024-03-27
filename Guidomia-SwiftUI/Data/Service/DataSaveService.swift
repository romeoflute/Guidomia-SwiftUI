//
//  DataSaveService.swift
//  Guidomia-SwiftUI
//
//  Created by Romeo Flauta on 3/27/24.
//

import Foundation

protocol DataSaveService {
    func saveCars(_ cars: [Car]) throws
}
