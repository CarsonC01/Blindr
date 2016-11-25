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

    // PRESENT ALERT METHOD
    func FBLogon(completion: @escaping (_ FbAccessToken: AccessToken) -> Void) {
    
        let loginManager = LoginManager()
        loginManager.logIn([ .publicProfile, .email], viewController: presentingViewController) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
                Alert.message(title: "Facebook can not log you in at this time", message: "Error: \(error.localizedDescription)")
            case .cancelled:
                print("User cancelled login.")
                Alert.message(title: "Facebook login was cancelled", message: "Complete Favebook login to use Blindr")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
    
                completion(accessToken)
                
            }

        }

    }
}
