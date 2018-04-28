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

    
    static var scoreBoardAPI = ScoreBoardAPI()
    
}
