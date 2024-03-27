//
//  DataError.swift
//  Guidomia-SwiftUI
//
//  Created by Romeo Flauta on 3/27/24.
//

import Foundation

enum DataError: Error {
    case noFileInBundle
    case noDataInFileFromBundle
    case unparsableJsonFile
    case unableToSaveInCoreData
    case unableToFetchFromCoreData
}

extension DataError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noFileInBundle:
            return NSLocalizedString("There is no data file in the bundle.", comment: "There is no data file in the bundle.")
        case .noDataInFileFromBundle:
            return NSLocalizedString("The file in the bundle does not contain data.", comment: "The file in the bundle does not contain data.")
        case .unparsableJsonFile:
            return NSLocalizedString("The supposed data in the file cannot be parsed.", comment: "The supposed data in the file cannot be parsed.")
        case .unableToSaveInCoreData:
            return NSLocalizedString("There was an error when saving to the local database.", comment: "There was an error when saving to the local database.")
        case .unableToFetchFromCoreData:
            return NSLocalizedString("There was an error when fetching from the local database.", comment: "There was an error when fetching from the local database.")
        }
    }
}

