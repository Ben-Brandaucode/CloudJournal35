//
//  EntryController.swift
//  Clouldjournal35
//
//  Created by Ben Brandau Brandau on 8/17/20.
//  Copyright © 2020 Ben Brandau. All rights reserved.
//

import Foundation
import CloudKit
class EntryController {
    
//MARK: Properties
    let publicDB =  CKContainer.default().publicCloudDatabase
    static let sharedInstance = EntryController()
    var entries: [Entry] = []
    
    //Mark: Functions
    func saveEntry(details: String, title: String , completion:@escaping(Result<Entry,EntryError>) -> Void){
        
        let newEntry =  Entry(details: details, title: title)
        let entryRecord = CKRecord(entry: newEntry)
        publicDB.save(entryRecord) { (record, error) in
            
            if let error = error {
                return completion(.failure(.ckerror(error)))
            }
            
            guard let record = record,
            let savedEntry = Entry(ckRecord: record)
                else {return completion(.failure(.couldnotUnwrap))}
            
            print("Saved Entry Sucesfully")
            completion(.success(savedEntry))
        }
    }

    func fetchedEntries(completion: @escaping (Result<[Entry]?,EntryError>) -> Void){
     let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: EntryString.recordTypeKey, predicate: predicate)
        
        publicDB.perform(query, inZoneWith: nil){ (records, error) in
            if let error = error{
                return completion(.failure(.ckerror(error)))
            }
            guard let records = records else {return completion(.failure(.couldnotUnwrap))}
            print ("fetched Entry Successfully")
            let entries = records.compactMap({Entry(ckRecord: $0)})
            completion(.success(entries))
            }
    }
}

