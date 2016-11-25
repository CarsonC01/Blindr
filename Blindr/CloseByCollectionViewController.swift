//
//  CloseByCollectionViewController.swift
//  Blindr
//
//  Created by Carson Carbery on 11/23/16.
//  Copyright © 2016 Carson Carbery. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "Cell"

class CloseByCollectionViewController: UICollectionViewController, LoginViewControllerDelegate, UserProfileViewControllerDelegate {
    
    //MARK: Properties
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // App StartUp processes
        handleInitialActivities()
    }
    
    // Handle when to present initial Login and User Detail views
    func handleInitialActivities() {
        
        // Check if user has already logged in
        
        let defaults = UserDefaults.standard
        userLoginInfo = defaults.object(forKey: "userLoginInfo") as? [String: String] ?? [String: String]()
        
        print(userLoginInfo)

        FIRAuth.auth()!.addStateDidChangeListener() { auth, user in
            if user != nil {
                self.showLoginView()
            
            }
            
        }
        
        showUserProfileView()
        
        
        // CHECK LOCAL DATA FOR ALREADY LOGGED IN AND DETAILS
        
//        let prefs = UserDefaults.standard
//        
//        let localDataTeamDict = prefs.object(forKey: "localDataTeamDict")
//        
//        guard let newTeamDict = localDataTeamDict as? [String:Any]
//            
//            else {
//                showLoginView()
//                return
//                
//        }
//        
//        print(localDataTeamDict)
//        
//        if newTeamDict["teamCode"] as! String == "" || newTeamDict["teamActive"] as! Bool == false {
//            showLoginView()
//            
//        } else if newTeamDict["teamName"] as! String == "" && newTeamDict["teamImage"] as! String == "" {
//            
//            showTeamDetailsView()
//            
//        } else {
//            
//            retrieveChallenges()
//        }

        
        
        
    }
    
    
    func showLoginView() {
        
        // present Login view controller
        
        let loginView = storyboard!.instantiateViewController(withIdentifier: "LoginView") as! LoginViewController
        
        loginView.delegate = self
        
        DispatchQueue.main.async(execute: { () -> Void in
            self.present(loginView, animated: true, completion: nil)
        })
        
    }
    
    func showUserProfileView() {
        
        //present Team details view controller
        
        let userProfileView = storyboard!.instantiateViewController(withIdentifier: "UserProfileView") as! UserProfileViewController
        
        userProfileView.delegate = self
        
        DispatchQueue.main.async(execute: { () -> Void in
            self.present(userProfileView, animated: true, completion: nil)
        })
        
        
    }

    
    
    // MARK: - Delegate Methods
    
    // LOGINVIEW DELEGATE METHOD
    
    func didLoginSuccessfully() {
        

        dismiss(animated: true, completion: nil)
        
        //handleInitialActivities()
        
    }
    
    func didEnterUserDetails() {
        
        dismiss(animated: true, completion: nil)
        
        //handleInitialActivities()
        
    }



    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
