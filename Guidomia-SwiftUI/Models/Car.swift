//
//  Car.swift
//  Guidomia-SwiftUI
//
//  Created by Romeo Flauta on 3/27/24.
//

import Foundation
import CoreData

struct Car: Codable, Identifiable, Hashable {
    var id: String { model }
    let consList: [String]
    let customerPrice: Double
    let make: String
    let marketPrice: Double
    let model: String
    let prosList: [String]
    let rating: Int
}

extension Car {
    private func convertToCDCar(context: NSManagedObjectContext) -> CDCar {
        let cdCar = CDCar(context: context)
        cdCar.id = self.id
        cdCar.customerPrice = self.customerPrice
        cdCar.make = self.make
        cdCar.marketPrice = self.marketPrice
        cdCar.model = self.model
        cdCar.rating = Int64(self.rating)
        
        for oneCon in self.consList {
            let con = Con(context: context)
            con.details = oneCon
            cdCar.addToConsList(con)
        }
        
        for onePro in self.prosList {
            let pro = Pro(context: context)
            pro.details = onePro
            cdCar.addToProsList(pro)
        }
        
        return cdCar
    }
    
    
    
    static func convertToCDCars(_ cars: [Car], context: NSManagedObjectContext) -> [CDCar] {
        return cars.map { $0.convertToCDCar(context: context) }
    }
    
    static func convertFromCDCars(_ cdCars: [CDCar]) -> [Car] {
        return cdCars.map { $0.convertToCar() }
    }
}
