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
    
    //MARK: IB Outlets
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //MARK: Properties
    
    var delegate: LoginViewControllerDelegate?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func emailSignUp(_ sender: Any) {
        
        guard let userEmail = emailTextField.text,
            let password = passwordTextField.text
        else {
            let alert = Alert(presentingViewController: self)
            alert.message(title: "Some fields are blank", message: "To sign up fill in the Email and Password fields then press Signup")
            return
        }
        
        FIRAuth.auth()!.createUser(withEmail: userEmail,
                                   password: password)
            { user, error in
            if error == nil {
                
                FIRAuth.auth()?.signIn(withEmail: userEmail,password: password) {
                    (user, error) in
                    
                    print(error?.localizedDescription ?? "No Error exists")
                    
                    if error == nil {

                        self.delegate?.didLoginSuccessfully()
                
                    } else {
                        let alert = Alert(presentingViewController: self)
                        alert.message(title: "Blindr is not able to Sign Up at this time", message: "Error: \(error?.localizedDescription)")
                    }
                }
            }
        }
    }
    
    
    @IBAction func emailLogin(_ sender: Any) {
        
    }
    
        
    
    @IBAction func FBLogin(_ sender: UIButton) {
        
        var userLoginInfo = [String:Any]()
        
        // logon with Facebook - get authorisation token
        let faceBookOps = FacebookOps(presentingViewController: self)
        faceBookOps.FBLogon() {
            (accessToken) in
            
                // Retrieve user information from Facebook Graph
                faceBookOps.getUserInfo() {
                    (responseDictionary) in
                        
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
            
                
                // Perform Sign in to Firebase with credential = Facebook authentication token
            
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: accessToken.authenticationToken)
            
                FIRAuth.auth()?.signIn(with: credential) { (user, error) in
                    
                    print(error?.localizedDescription ?? "No Error exists")
                    
                    if error == nil {
                        
                        userLoginInfo ["fBToken"] = accessToken.authenticationToken
                        userLoginInfo ["uid"] = user?.uid
                        
                        let defaults = UserDefaults.standard
                        defaults.set(userLoginInfo, forKey: "userLoginInfo")
                        print(defaults.object(forKey: "userLoginInfo")!)
                        
                        self.delegate?.didLoginSuccessfully()
                        
                        print("SIGNED IN AT FIREBASE")
                        
                    } else {
                        
                        let alert = Alert(presentingViewController: self)
                        alert.message(title: "Blindr cannot sign in at this time", message: "Error: \(error?.localizedDescription)")
                        print("ALERT ERROR WITH FIREBASE SIGN IN")
                    }
                    
                }
                
            }

        }
    
}

