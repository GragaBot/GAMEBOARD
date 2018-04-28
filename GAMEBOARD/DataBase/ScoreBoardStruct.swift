//
//  ScoreBoardStruct.swift
//  GAMEBOARD
//
//  Created by T on 4/27/18.
//  Copyright © 2018 T. All rights reserved.
//

import Foundation
import UIKit

class ScoreBoard {
    let scoreBoardID: String?
    let creatorID: String?
    //var timeStamp:String?
    
    var players: [String]?
    var scores: [Int]?
    
    
    init(scoreBoardID: String?, creatorID: String? , players:[String]?,scores:[Int]?) {
        self.scoreBoardID = scoreBoardID
        self.creatorID = creatorID
        //self.timeStamp = timeStamp
        self.players = players
        self.scores = scores
    }
    static func createScoreBoard(scoreBoardID:String?, creatorID:String? , players:[String]?, scores:[Int]?) -> ScoreBoard?{
        
        return ScoreBoard(scoreBoardID: scoreBoardID, creatorID: creatorID,  players: players, scores: scores)
    }
    
    func dictValue() -> [String:Any] {
        var scoreBoardDict = [String:Any]()
        scoreBoardDict["creatorID"] = creatorID
        scoreBoardDict["players"] = players
        scoreBoardDict["scores"] = scores
        
        return scoreBoardDict
    }
}
