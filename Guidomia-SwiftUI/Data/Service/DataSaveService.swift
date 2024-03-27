//
//  DataSaveService.swift
//  Guidomia-SwiftUI
//
//  Created by Romeo Flauta on 3/27/24.
//

import Foundation
import CoreData

protocol DataSaveService {
    static func saveCars(_ cars: [Car], context: NSManagedObjectContext) throws
}
