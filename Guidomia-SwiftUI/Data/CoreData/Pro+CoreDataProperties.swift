//
//  Pro+CoreDataProperties.swift
//  Guidomia-SwiftUI
//
//  Created by Romeo Flauta on 3/27/24.
//
//

import Foundation
import CoreData


extension Pro {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pro> {
        return NSFetchRequest<Pro>(entityName: "Pro")
    }

    @NSManaged public var details: String?
    @NSManaged public var car: CDCar?

}

extension Pro : Identifiable {

}
