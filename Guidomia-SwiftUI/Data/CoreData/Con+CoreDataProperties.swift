//
//  Con+CoreDataProperties.swift
//  Guidomia-SwiftUI
//
//  Created by Romeo Flauta on 3/27/24.
//
//

import Foundation
import CoreData


extension Con {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Con> {
        return NSFetchRequest<Con>(entityName: "Con")
    }

    @NSManaged public var details: String?
    @NSManaged public var car: CDCar?

}

extension Con : Identifiable {

}
