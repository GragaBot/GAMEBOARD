//
//  ScoreBoardAPI.swift
//  GAMEBOARD
//
//  Created by T on 4/27/18.
//  Copyright © 2018 T. All rights reserved.
//

import Foundation
import FirebaseDatabase

class ScoreBoardAPI: NSObject {
    let scoreBoardRef = API().scoreBoardRef
    
    func createScoreBoard(withHost creatorID:String, players:[String], scores:[Int], completed:@escaping()->Void){
        
        
        let autoRef = scoreBoardRef.childByAutoId()
        let autoRefId = autoRef.key
        
        
        let newScoreBoard = ScoreBoard.init(scoreBoardID: autoRefId, creatorID: creatorID, players: players, scores: scores)
        
        scoreBoardRef.child(autoRefId).setValue(newScoreBoard.dictValue(), withCompletionBlock:{
            error, _ in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
        })
    }
    
    func updateScoreBoard(withID scoreBoardID: String, dictValue:[String:Any], onSuccess: @escaping()->Void, onError: @escaping (Error) -> Void) {
        scoreBoardRef.child(scoreBoardID).setValue(dictValue, withCompletionBlock: {
            error, _ in
            if error != nil {
                onError(error!)
                return
            }
            onSuccess()
            
        })
    }
     
}
