//
//  UsersNearbyTableViewController.swift
//  Blindr
//
//  Created by Carson Carbery on 11/28/16.
//  Copyright © 2016 Carson Carbery. All rights reserved.
//

import UIKit

class UsersNearbyTableViewController: UITableViewController {
    
    //MARK: Properties
    
    var usersToDisplay: [UserProfile] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firebaseService = FirebaseService()
        firebaseService.retrieveUsers() {
            (results) in
            
            if results.count > 0 {
                self.usersToDisplay = results
                self.tableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersToDisplay.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        print(usersToDisplay[indexPath.row].description)
        
        cell.textLabel?.text = "\(usersToDisplay[indexPath.row].firstName) \(usersToDisplay[indexPath.row].surname) "
        
        return cell
    }
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
