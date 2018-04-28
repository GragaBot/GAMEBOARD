//
//  API.swift
//  GAMEBOARD
//
//  Created by T on 4/27/18.
//  Copyright © 2018 T. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class API: NSObject {
    var scoreBoardRef = Database.database().reference().child("ScoreBoard")
    var userRef = Database.database().reference().child("Users")
    var postRef = Database.database().reference().child("Posts")
    var feedRef = Database.database().reference().child("Feeds")
    

    
    static var scoreBoardAPI = ScoreBoardAPI()
    static var userAPI = UserAPI()
    static var authAPI = AuthAPI()
    static var storageAPI = FIRStorageAPI()
    static var postAPI = PostAPI()
    static var feedAPI = FeedAPI()



    
}
