//
//  newMessageTableViewController.swift
//  FashionRaffle
//
//  Created by Mac on 6/25/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class newMessageTableViewController: UITableViewController {

    var userProfiles = [Profile]()
    var userLimit : UInt = 20
    var singleLoadCount : UInt = 20
    var toUserID = String()
    
    var messagesController: MessagesController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(done))
        fetchDetails()
        print("show all")
        
        
        tableView.es_addPullToRefresh {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.4, execute: {
                self.tableView.es_stopPullToRefresh()
            })
        }
        tableView.es_addInfiniteScrolling {
            self.loadMore()
        }
        
    }
    func done(){
        print("done")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    func fetchDetails() {
        Config.showPlainLoading(withStatus: nil)
        API.userAPI.fetchAllUsers(withLimitToLast: userLimit, completed: {
            fetchProfiles in
            self.userProfiles = fetchProfiles
            self.tableView.reloadData()
            Config.dismissPlainLoading()
        })
    }
    
    func loadMore() {
        if userLimit <= UInt(userProfiles.count) {
            userLimit = userLimit + singleLoadCount
            let checkCount = self.userProfiles.count
            API.userAPI.fetchAllUsers(withLimitToLast: userLimit, completed: {
                fetchProfiles in
                if fetchProfiles.count > checkCount {
                    self.userProfiles.removeAll()
                    self.userProfiles = fetchProfiles
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.2, execute: {
                        self.tableView.reloadData()
                        self.tableView.es_stopLoadingMore()
                        return
                    })
                }
                else {
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.5, execute: {
                        self.tableView.es_noticeNoMoreData()
                        return
                    })
                }
                
            })
        }
        else {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.5, execute: {
                self.tableView.es_noticeNoMoreData()
            })
        }
    }
    
  
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // TableView Delegate
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userProfiles.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "newMessageCell", for: indexPath) as! newMessageTableViewCell
        
        cell.selectedUser = userProfiles[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        toUserID = (userProfiles[indexPath.row].userID)!
        
        self.messagesController?.showChatControllerForUser(userProfiles[indexPath.row])
        
        let chatLogController = ChatLogController(collectionViewLayout: UICollectionViewFlowLayout())
        chatLogController.user = userProfiles[indexPath.row]
        navigationController?.pushViewController(chatLogController, animated: true)
        //print(toUserID, "append")
        
    }
    /*
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let removeID = userProfiles[indexPath.row].userID
        if let index = toUserID.index(of:removeID) {
            toUserID.remove(at: index)
            print(toUserID, "remove")
        }
    }*/
    
}
