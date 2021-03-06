//
//  ContactsTableViewController.swift
//  GAMEBOARD
//
//  Created by T on 4/28/18.
//  Copyright © 2018 T. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase

class ContactsTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    
    @IBOutlet var contactTableView: UITableView!
    var userProfile = [Profile]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Profile.currentUser?.friends?.isEmpty != true {
            fetchSelectedUser()
        }
        contactTableView.delegate = self
        contactTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return userProfile.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactsCell", for: indexPath) as! ContactsTableViewCell
        cell.selectedUser = userProfile[indexPath.row]
        
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
 
    
    
    func fetchSelectedUser(){
        Config.showPlainLoading(withStatus: nil)
        
        
        for userID in (Profile.currentUser?.friends)! {
            
            print(userID)
            
            API.userAPI.fetchUserInfo(withID: userID, completion: {
                fetchProfiles in
                self.userProfile.append(fetchProfiles!)
                self.contactTableView.reloadData()
                Config.dismissPlainLoading()

            })
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        findUser(text: searchBar.text!)
    }
    func showSearchedUser(text: String) -> Void{
        API.userAPI.fetchUserInfo(withID: text, completion: {
            fetchProfiles in
            if fetchProfiles?.userID != Profile.currentUser?.userID {
               if  (Profile.currentUser?.friends?.count)! < self.userProfile.count{
                    self.userProfile.remove(at: 0)
                    self.userProfile.insert(fetchProfiles!, at: 0)
                    self.contactTableView.reloadData()
               } else {
                    self.userProfile.insert(fetchProfiles!, at: 0)
                    self.contactTableView.reloadData()
                }
            }
            print(String(self.userProfile.count) + "++++++++")
            //self.userProfile.remove(at: 0)
        })
    }
    func findUser(text: String)->Void{
        
        API().userRef.queryOrdered(byChild: "username").queryEqual(toValue: text).observeSingleEvent(of: .childAdded, with: { (snapshot) in
            let userID = "\(snapshot.key)"
            //print("\(snapshot.key)")
            self.showSearchedUser(text: userID)
            
        })
    }
}

