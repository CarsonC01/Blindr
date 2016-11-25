//
//  LoginViewController.swift
//  Blindr
//
//  Created by Carson Carbery on 11/24/16.
//  Copyright © 2016 Carson Carbery. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import Firebase

protocol LoginViewControllerDelegate {
    func didLoginSuccessfully()
}

let uid: String = ""

class LoginViewController: UIViewController {
    
    //MARK: Properties
    
    var delegate: LoginViewControllerDelegate?
    var fBAccessToken: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    @IBAction func FBLogin(_ sender: UIButton) {
        
        
        // login to Facebook
        // if FB success {
        // get users information
        // login to firebase  
        // if FIR success {
        //  save info to user defaults
        // }
        // else alert FIR error
        // }
        // else alert FB error
        //
        
        var userLoginInfo = [String:Any]()
        
//        let loginManager = LoginManager()
//        loginManager.logIn([ .publicProfile, .email], viewController: self) { loginResult in
//            switch loginResult {
//            case .failed(let error):
//                print(error)
//                Alert.message(title: "Facebook can not log you in at this time", message: "Error: \(error.localizedDescription)")
//            case .cancelled:
//                print("User cancelled login.")
//                Alert.message(title: "Facebook login was cancelled", message: "Complete Favebook login to use Blindr")
//            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
        
        let faceBookOps = FacebookOps(presentingViewController: self)
        
        faceBookOps.FBLogon() {
            (accessToken) in
            
            print(accessToken)
            
            if accessToken.authenticationToken != "" {
                self.fBAccessToken = accessToken.authenticationToken
            }
            

        }
            
            
        
                // Retrieve user information from Facebook Graph
                
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
                            
                            let fotoPath = responseDictionary["picture"] as! NSDictionary
                            let fotoData = fotoPath["data"] as! NSDictionary
                            if let fBFotoUrl = fotoData["url"] {
                                print(fBFotoUrl)
                            }
                            
                            userLoginInfo = ["name": responseDictionary["name"]!,
                                        "email": responseDictionary["email"]!,
                                        "fBId": responseDictionary["id"]!,
                                        "firstName": responseDictionary["first_name"]!,
                                        "surname": responseDictionary["last_name"]!,
                                        "gender": responseDictionary["gender"]!,
                                        "picture": fotoData["url"]!
                                        ]
                            
                         }
                    }
                }
                
                
                // Perform Sign in to Firebase credential = Facebook authentication token
        
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: fBAccessToken)

        
                FIRAuth.auth()?.signIn(with: credential) { (user, error) in
                    
                    print(error?.localizedDescription ?? "No Error exists")
                    
                    if error == nil {
                    
                        userLoginInfo ["fBToken"] = self.fBAccessToken
                        userLoginInfo ["uid"] = user?.uid
                        
                        let defaults = UserDefaults.standard
                        defaults.set(userLoginInfo, forKey: "userLoginInfo")
                        print(defaults.object(forKey: "userLoginInfo")!)
                        
                        self.delegate?.didLoginSuccessfully()
                        
                        print("SIGNED IN AT FIREBASE")
                        
                    } else {
                        
                        print("ALERT ERROR WITH FIREBASE SIGN IN")
                    }
                    
                }
                
            }
        //}
        
        
    //}
    
}

