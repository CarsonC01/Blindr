//
//  FirebaseOperations.swift
//  Blindr
//
//  Created by Carson Carbery on 11/25/16.
//  Copyright © 2016 Carson Carbery. All rights reserved.
//

import Foundation
import Firebase

class FirebaseService {
    
    //MARK: Properties
    let ref = FIRDatabase.database().reference(withPath: "User-Profile")
        
    // Create User Profile Database record in FIREBASE
    
    //MARK: FIXIT add completion handler and error alerts in calling classes

    func createFIRUser(userProfile: UserProfile) /* add completion handler */ {
        let userName = "\(userProfile.firstName) \(userProfile.surname)"
        
        let userProfileRef = self.ref.child(userName.lowercased())
        userProfileRef.setValue(userProfile.toAnyObject()) {
            (error, reference) in
            
            //completion(error)     
        }

    }
    
    func retrieveUsers(completion:@escaping ([UserProfile])-> Void)  {
        
         ref.observe(.value, with: { snapshot in
            
            var userprofiles: [UserProfile] = []
            
            for item in snapshot.children {
    
                let userProfile = UserProfile(snapshot: item as! FIRDataSnapshot)
                userprofiles.append(userProfile)
            }
            
            completion(userprofiles)
            
        })
    }
    
    
    
}


