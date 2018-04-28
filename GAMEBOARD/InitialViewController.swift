//
//  InitialViewController.swift
//  GAMEBOARD
//
//  Created by T on 4/27/18.
//  Copyright © 2018 T. All rights reserved.
//

import UIKit
import Firebase


class InitialViewController: UIViewController {

    @IBOutlet weak var searchSB: UIButton!
    @IBOutlet weak var sbID: UITextField!
    @IBOutlet weak var createSB: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        createSB.clipsToBounds = true
        createSB.layer.cornerRadius = createSB.bounds.size.height/2
        createSB.layer.borderColor = UIColor.white.cgColor
        createSB.layer.borderWidth = 3
        
        searchSB.clipsToBounds = true
        searchSB.layer.cornerRadius = searchSB.bounds.size.height/2
        searchSB.layer.borderColor = UIColor.white.cgColor
        searchSB.layer.borderWidth = 3
        
        
        sbID.clipsToBounds = true
        sbID.layer.cornerRadius = searchSB.bounds.size.height/2
        sbID.layer.borderWidth = 3
        sbID.layer.borderColor = UIColor.white.cgColor
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createScoreBoard(_ sender: Any) {
        API.scoreBoardAPI.createScoreBoard(withHost: GlobalVariables.playerList[0], players: GlobalVariables.playerList, scores: GlobalVariables.playerScores, completed:{
                print("pass"
            )
        })
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
