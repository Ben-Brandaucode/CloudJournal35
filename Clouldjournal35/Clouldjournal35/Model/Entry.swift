//
//  Entry.swift
//  Clouldjournal35
//
//  Created by Ben Brandau Brandau on 8/17/20.
//  Copyright © 2020 Ben Brandau. All rights reserved.
//

import Foundation
import CloudKit

class EntryString {
    static let recordTypeKey = "Entry"
    fileprivate static let detailsKey = "details"
    fileprivate static let titleKey = "title"
    fileprivate static let timestampKey = "timestamp"
}
class Entry {
    var details: String
    var timestamp: Date
    var title: String
    
    init (details: String, timestamp: Date = Date(), title: String){
        self.details = details
        self.title = title
        self.timestamp = timestamp
    }
}// end of class

// Extensions
extension CKRecord {
    convenience init (entry: Entry){
        self.init(recordType: EntryString.recordTypeKey)
        
        self.setValuesForKeys([
            EntryString.detailsKey: entry.details,
            EntryString.titleKey: entry.title,
            EntryString.timestampKey: entry.timestamp
        ])
}
}
extension Entry {
    convenience init? (ckRecord:CKRecord){
            guard let details = ckRecord[EntryString.detailsKey] as? String,
            let title = ckRecord[EntryString.titleKey] as? String,
            let timestamp = ckRecord[EntryString.timestampKey] as? Date
            else {return nil}
            self.init(details: details, timestamp: timestamp, title: title)
        }
}
