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
    
    
    enum ActionButtonState: String{
        case notFriend = "request"
        case isFriend = "invite"
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
