//
//  invitationPopViewController.swift
//  GAMEBOARD
//
//  Created by T on 4/30/18.
//  Copyright © 2018 T. All rights reserved.
//

import UIKit

class invitationPopViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    var userProfile = [Profile]()

    @IBOutlet weak var dButton: UIButton!
    @IBOutlet var backgroundview: UIView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return userProfile.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "invitationCell", for: indexPath) as! invitationPopTableViewCell
        print(indexPath.row)

        cell.selectedUser = userProfile[indexPath.row]
        cell.delegate = self as? CustomCellUpdater
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func fetchSelectedUser(){
        Config.showPlainLoading(withStatus: nil)
            var userID = [String]()

        API().userRef.child((Profile.currentUser?.userID)!).child("invites").observe(.childAdded, with: {
            snapshot in

            if let temp = snapshot.key as? String{
                userID.append(temp)
                API.userAPI.fetchUserInfo(withID: temp, completion: {
                    fetchProfiles in
                    self.userProfile.append(fetchProfiles!)
                    Config.dismissPlainLoading()
                    self.invitationTable.reloadData()
                    
                })
            }
         
        })
     
    }
    

    @IBOutlet weak var invitationTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchSelectedUser()

        invitationTable.delegate = self
        invitationTable.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func dismiss(_ sender: Any) {
      dismiss(animated: true, completion: nil)
    }
    
    func updateTableView() {
        invitationTable.reloadData()
        print("reload")
    }

   
}
