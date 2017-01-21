//
//  CloseByCollectionViewController.swift
//  Blindr
//
//  Created by Carson Carbery on 11/23/16.
//  Copyright © 2016 Carson Carbery. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "UserCell"

class CloseByCollectionViewController: UICollectionViewController, LoginViewControllerDelegate, UserProfileViewControllerDelegate {
    
    //MARK: Properties
    var usersToDisplay: [UserProfile] = []
    var faceImages: [UIImage] = []
    fileprivate let reuseIdentifier = "UserCell"
    fileprivate let sectionInsets = UIEdgeInsets(top: 20.0, left: 10.0, bottom: 20.0, right: 10.0)
    fileprivate let itemsPerRow: CGFloat = 2

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier) as! CloseByCell
        
        // Get placeholder face images
        faceImages = FaceImages.setUpFaceImages()
        
        // App StartUp processes
        handleInitialActivities()
    }
    
    // Handle when to present initial Login and User Detail views
    func handleInitialActivities() {
        
        // Check if user has already logged in
        
        FIRAuth.auth()!.addStateDidChangeListener() { auth, user in
            if user == nil {
                self.showLoginView()
            
            } else {
                // Check if the users account has been created as active
                let defaults = UserDefaults.standard
                let active = defaults.object(forKey:"active") as? Bool ?? false
                
                if !active {
                    
                    self.showUserProfileView()
                } else {
                    
                    self.retrieveUsersCloseBy()
                    
                }
            }
        }
    }
    
    func retrieveUsersCloseBy() {
    
        let firebaseService = FirebaseService()
        firebaseService.retrieveUsers() {
            (results) in
            
            if results.count > 0 {
                self.usersToDisplay = results
                self.collectionView?.reloadData()
            }
        }

    
    
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
        
        handleInitialActivities()
    }
    
    func didEnterUserDetails() {
        
        dismiss(animated: true, completion: nil)
        
        handleInitialActivities()
        
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
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return usersToDisplay.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CloseByCell
    
        cell.userNameLabel.text = "\(usersToDisplay[indexPath.row].firstName)"
        cell.userAgeLabel.text = "\(usersToDisplay[indexPath.row].age)"
        
        //cell.userFotoView.image = faceImages[indexPath.row]
        
        switch indexPath.row {
        case 0:
            cell.userFotoView.image = UIImage(named: "girl1")
        case 1:
            cell.userFotoView.image = UIImage(named: "guy1")
        case 2:
            cell.userFotoView.image = UIImage(named: "girl2")
        case 3:
            cell.userFotoView.image = UIImage(named: "guy2")
        case 4:
            cell.userFotoView.image = UIImage(named: "girl1")
        case 5:
            cell.userFotoView.image = UIImage(named: "guy1")
        case 6:
            cell.userFotoView.image = UIImage(named: "girl2")
        case 7:
            cell.userFotoView.image = UIImage(named: "guy2")
        default:
            cell.userFotoView.image = UIImage(named: "girl1")

        }
        
        cell.backgroundColor = UIColor.white
        
        

        
        
    
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

extension CloseByCollectionViewController : UICollectionViewDelegateFlowLayout {
 
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
