//
//  ContactsTableViewCell.swift
//  GAMEBOARD
//
//  Created by T on 4/28/18.
//  Copyright © 2018 T. All rights reserved.
//

import UIKit

class ContactsTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var actionButton: UIButton!
    
    
    var currentUserID = Profile.currentUser?.userID
    
    enum FollowButtonState: String {
        case CurrentUser = ""
        case NotFriend = "+"
        case Friend = "x"
    }
    
    var followbuttonState: FollowButtonState = .CurrentUser {
        willSet(newState) {
            actionButton.clipsToBounds = true
            actionButton.layer.cornerRadius = actionButton.bounds.size.height/2
            switch newState {
            case .CurrentUser:
                actionButton.isHidden = true
            case .NotFriend:
                actionButton.isHidden = false
                actionButton.backgroundColor = UIColor.green
                actionButton.setTitleColor(UIColor.white, for: .normal)
                actionButton.layer.borderWidth = 0
            case .Friend:
                actionButton.isHidden = false
                actionButton.backgroundColor = UIColor.red
                actionButton.setTitleColor(UIColor.white, for: .normal)
                
            }
            actionButton.setTitle(newState.rawValue, for: UIControlState())
        }
    }
    
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
            if (Profile.currentUser?.friends?.contains((selectedUser?.userID)!))!{
                //isFriendState = true
                self.followbuttonState = .Friend
            } else {
                self.followbuttonState = .NotFriend
                //isFriendState = false
            }
        }
    }
    
    @IBAction func actions(_ sender: Any) {
        if followbuttonState == .Friend {
            //unfriend
            API().userRef.child(currentUserID!).child("friends").child((selectedUser?.userID)!).removeValue()
            
            API().userRef.child((selectedUser?.userID)!).child("friends").child(currentUserID!).removeValue()
            self.followbuttonState = .NotFriend
            let index = Profile.currentUser?.friends?.index(of: (selectedUser?.userID)!)
            Profile.currentUser?.friends?.remove(at: index!)
            
        }
        else if followbuttonState == .NotFriend{
            //invite
            API().userRef.child((self.selectedUser?.userID)!).child("invites").child((Profile.currentUser?.userID)!).setValue("friend")
            
           /* API().userRef.child(currentUserID!).child("friends").child((selectedUser?.userID)!).setValue(true)
            API().userRef.child((selectedUser?.userID)!).child("friends").child(currentUserID!).setValue(true)
            Profile.currentUser?.friends?.append((selectedUser?.userID)!)*/
            //self.followbuttonState = .Friend

        }
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
