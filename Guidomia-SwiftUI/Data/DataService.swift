//
//  DataService.swift
//  Guidomia-SwiftUI
//
//  Created by Romeo Flauta on 3/27/24.
//

import SwiftUI

final class DataService {
    func loadCars() {
        let filename = "Cars"
        guard let file = Bundle.main.path(forResource: filename, ofType: "json")
        else {
            fatalError("Unable to locate file \"\(filename)\" in main bundle.")
        }
        
        do {
            guard let data = try String(contentsOfFile: file).data(using: .utf8) else {
                fatalError("No data in file \"\(filename)\" in main bundle.")
            }
            let decoder = JSONDecoder()

            if let cars = try? decoder.decode([Car].self, from: data) {
                print("cars: \(cars)")
            }
            
        } catch {
            fatalError("Unable to load \"\(filename)\" from main bundle:\n\(error)")
        }
    }
}
