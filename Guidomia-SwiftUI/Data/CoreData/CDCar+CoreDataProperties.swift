//
//  CDCar+CoreDataProperties.swift
//  Guidomia-SwiftUI
//
//  Created by Romeo Flauta on 3/27/24.
//
//

import Foundation
import CoreData


extension CDCar {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDCar> {
        return NSFetchRequest<CDCar>(entityName: "CDCar")
    }

    @NSManaged public var id: String?
    @NSManaged public var customerPrice: Double
    @NSManaged public var make: String?
    @NSManaged public var marketPrice: Double
    @NSManaged public var model: String?
    @NSManaged public var rating: Int64
    @NSManaged public var imageName: String?
    @NSManaged public var consList: NSSet?
    @NSManaged public var prosList: NSSet?

}

// MARK: Generated accessors for consList
extension CDCar {

    @objc(addConsListObject:)
    @NSManaged public func addToConsList(_ value: Con)

    @objc(removeConsListObject:)
    @NSManaged public func removeFromConsList(_ value: Con)

    @objc(addConsList:)
    @NSManaged public func addToConsList(_ values: NSSet)

    @objc(removeConsList:)
    @NSManaged public func removeFromConsList(_ values: NSSet)

}

// MARK: Generated accessors for prosList
extension CDCar {

    @objc(addProsListObject:)
    @NSManaged public func addToProsList(_ value: Pro)

    @objc(removeProsListObject:)
    @NSManaged public func removeFromProsList(_ value: Pro)

    @objc(addProsList:)
    @NSManaged public func addToProsList(_ values: NSSet)

    @objc(removeProsList:)
    @NSManaged public func removeFromProsList(_ values: NSSet)

}

extension CDCar : Identifiable {

}

extension CDCar {
    func convertToCar() -> Car {
        var allCons: [String] = []
        if let cdConsNSSet = consList, let cdConsSet = cdConsNSSet as? Set<Con>, cdConsSet.count > 0 {
            allCons = cdConsSet.map { $0.details ?? "" }
            allCons.sort()
        }
        
        var allPros: [String] = []
        if let cdProsNSSet = prosList, let cdProsSet = cdProsNSSet as? Set<Con>, cdProsSet.count > 0 {
            allPros = cdProsSet.map { $0.details ?? "" }
            allPros.sort()
        }
        let car = Car(
            consList: allCons,
            customerPrice: customerPrice,
            make: make ?? "",
            marketPrice: marketPrice,
            model: model ?? "",
            prosList: allPros,
            rating: Int(rating),
            imageName: imageName ?? "")
        
        return car
    }
}

