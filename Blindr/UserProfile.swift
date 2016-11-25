//
//  UserProfile.swift
//  Blindr
//
//  Created by Carson Carbery on 11/22/16.
//  Copyright © 2016 Carson Carbery. All rights reserved.
//

import Foundation
import Firebase

enum Sex {
    case male
    case female
}


struct UserProfile {
    
    let key: String
    let firstName: String
    let surname: String
    let sex: String
    let age: Int
    let description: String
    let userId: String
    let ref: FIRDatabaseReference?
    var active: Bool = false
    
    init(key: String, firstName: String, surname: String, sex: String, age: Int, description: String, userId: String, active: Bool) {
        self.key = key
        self.firstName = firstName
        self.surname = surname
        self.sex = sex
        self.age = age
        self.description = description
        self.userId = userId
        self.active = active
        self.ref = nil
    }
    
//    init(snapshot: FIRDataSnapshot) {
//        key = snapshot.key
//        let snapshotValue = snapshot.value as! [String: AnyObject]
//        name = snapshotValue["name"] as! String
//        addedByUser = snapshotValue["addedByUser"] as! String
//        completed = snapshotValue["completed"] as! Bool
//        ref = snapshot.ref
//    }
    
    func toAnyObject() -> Any {
        return [
            "key": key,
            "firstName" : firstName,
            "surname" : surname,
            "sex": sex,
            "age": age,
            "description": description,
            "userid": userId,
            "active" : active
        ]
    }
    
}



