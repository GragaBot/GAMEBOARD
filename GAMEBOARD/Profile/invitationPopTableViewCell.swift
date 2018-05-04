//
//  invitationPopTableViewCell.swift
//  GAMEBOARD
//
//  Created by T on 4/30/18.
//  Copyright © 2018 T. All rights reserved.
//

import UIKit

protocol CustomCellUpdater: class { // the name of the protocol you can put any
    func updateTableView()
}

class invitationPopTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    var currentUserID = Profile.currentUser?.userID
    var inviteType = "false"
    weak var delegate: CustomCellUpdater?

    @IBOutlet weak var username: UILabel!
    var selectedUser : Profile? {
        didSet{
            updateCell()
        }
    }
    func updateCell() {
        
        
        if let user = selectedUser {
            
            if let url = user.profilePicUrl {
                let data = try? Data(contentsOf: url)
                self.profileImage.image = UIImage(data:data!)
            }
            else{
                self.profileImage.image = #imageLiteral(resourceName: "background")
            }
            username.text = user.username
           
        }
        //typeInvite()
    }
    /*
    func typeInvite(){

        API().userRef.child(currentUserID!).child("invites").child((selectedUser?.userID)!).observeSingleEvent(of: .value, with: { snapshot in
                let temp = snapshot.value as? String
                
            })
            //print(String(describing: API().userRef.child(currentUserID!).child("invites").child((selectedUser?.userID)!).description()))
            print("tpye of invite")
        
        
    }*/
    
    @IBAction func declineInvite(_ sender: Any) {
            Config.showError(withStatus: "Success")
        API().userRef.child(currentUserID!).child("invites").child((selectedUser?.userID)!).removeValue()
        
            //delegate?.updateTableView()
       
    }
    @IBAction func acceptInvite(_ sender: Any) {
            Config.showError(withStatus: "Success")
        API().userRef.child(currentUserID!).child("friends").child((selectedUser?.userID)!).setValue(true)
        API().userRef.child((selectedUser?.userID)!).child("friends").child(currentUserID!).setValue(true)
        Profile.currentUser?.friends?.append((selectedUser?.userID)!)
        API().userRef.child(currentUserID!).child("invites").child((selectedUser?.userID)!).removeValue()
        
        

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

