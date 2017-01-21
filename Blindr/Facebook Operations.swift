//
//  Facebook Operations.swift
//  Blindr
//
//  Created by Carson Carbery on 11/25/16.
//  Copyright © 2016 Carson Carbery. All rights reserved.
//

import Foundation
import FacebookCore
import FacebookLogin


class FacebookOps {

    private let presentingViewController: UIViewController

    init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
    }

    // Login via Facebook
    func FBLogon(completion: @escaping (_ fBToken: AccessToken) -> Void) {
    
        let loginManager = LoginManager()
        loginManager.logIn([ .publicProfile, .email], viewController: presentingViewController) { loginResult in
            
            switch loginResult {
            case .failed(let error):
                print(error)
                let alert = Alert(presentingViewController: self.presentingViewController)
                alert.message(title: "Facebook can not log you in at this time", message: "Error: \(error.localizedDescription)")
            case .cancelled:
                print("User cancelled login.")
                let alert = Alert(presentingViewController: self.presentingViewController)
                alert.message(title: "Facebook login was cancelled", message: "Complete Facebook login to use Blindr")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print(grantedPermissions)
                completion(accessToken)
                
            }
        }
    }
    
    // Get Facebook user information from FB Graph api
    func getUserInfo(completion: @escaping (_ responseDictionary: [String:Any]) -> Void) {
        
        let params = ["fields" : "email, name, first_name, last_name, gender, id, picture.type(large), cover"]
        let graphRequest = GraphRequest(graphPath: "/me", parameters: params)
        graphRequest.start {
            (urlResponse, requestResult) in
            
            switch requestResult {
            case .failed(let error):
                print("error in graph request:", error)
                break
            case .success(let graphResponse):
                if let responseDictionary = graphResponse.dictionaryValue {
                    print(responseDictionary)
                    
                    completion(responseDictionary)
                    
                }
            }
        }

        
        
    }
    
    
    
}
