//
//  entryError.swift
//  Clouldjournal35
//
//  Created by Ben Brandau Brandau on 8/17/20.
//  Copyright © 2020 Ben Brandau. All rights reserved.
//

import Foundation

enum EntryError: LocalizedError {
    case ckerror(Error)
    case couldnotUnwrap
    var errorDescription: String{
        switch self {
            
        case .ckerror(let error):
            return error.localizedDescription
            
        case .couldnotUnwrap:
            return " Unable to get this Entry"
        }
}
}
