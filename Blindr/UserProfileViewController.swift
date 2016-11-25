//
//  UserProfileViewController.swift
//  Blindr
//
//  Created by Carson Carbery on 11/23/16.
//  Copyright © 2016 Carson Carbery. All rights reserved.
//

import UIKit
import Firebase

protocol UserProfileViewControllerDelegate {
    func didEnterUserDetails()
}

class UserProfileViewController: UIViewController {
    
    //MARK: IB Outlets
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var sexTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    //MARK: Properties
    
    var delegate: UserProfileViewControllerDelegate?
    let ref = FIRDatabase.database().reference(withPath: "User-Profile")
    var age = 0
    var userLoginInfo: [String : String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        userLoginInfo = defaults.object(forKey: "userLoginInfo") as? [String: String] ?? [String: String]()
        
        print(userLoginInfo)
        
        firstNameTextField.text = userLoginInfo["firstName"]
        surnameTextField.text = userLoginInfo["surname"]
        sexTextField.text = userLoginInfo["gender"]
        
    }
    
    @IBAction func saveUserProfile(_ sender: Any) {

        guard let firstName = firstNameTextField.text,
            let surname = surnameTextField.text,
            let sex = sexTextField.text,
            let age = Int(ageTextField.text!),
            let description = descriptionTextView.text
        else {
            //MARK: FIXIT - ALERT ERROR
            print("ALERT - REQUIRED FIELDS NOT FILLED IN")
            return
        }
        
        var userId = userLoginInfo["uid"]!
        if userLoginInfo["uid"] != nil {
            userId = userLoginInfo["uid"]!
        } else {
            //MARK: FIXIT - ALERT ERROR
            print("ALERT NO UID FOUND")
        }
        
        
        let userProfile = UserProfile(key: "abc", firstName: firstName, surname: surname, sex: sex, age: age, description: description, userId: userId, active: true)
        
        let userName = "\(firstName) \(surname)"
        let userProfileRef = self.ref.child(userName.lowercased())
        
        userProfileRef.setValue(userProfile.toAnyObject())
        
        self.delegate?.didEnterUserDetails()

     }
    
    
}
