//
//  SettingTableViewCell.swift
//  GAMEBOARD
//
//  Created by T on 1/13/18.
//  Copyright © 2018 T. All rights reserved.
//

import UIKit

class SettingTableViewCell: UITableViewCell,UITextFieldDelegate {

    @IBOutlet weak var done: UIButton!
    
    @IBOutlet weak var activeButton: UIButton!
    
    var cellIndex :NSInteger!
    var indPath: IndexPath!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        done.layer.borderWidth = 3
        done.layer.borderColor = UIColor.orange.cgColor
        activeButton.layer.borderWidth = 3
        activeButton.layer.borderColor = UIColor.orange.cgColor
        
        
        
    }
    
    @IBAction func SetName(_ sender: UIButton) {
        

        print(GlobalVariables.playerList)
        
        GlobalVariables.cellindex = indPath
        
        
    }
    
  
    @IBAction func SetActive(_ sender: UIButton) {
        /*
        var countActive = 0
        for index in 0...GlobalVariables.active.count - 1 {
            if GlobalVariables.active[index] == 1 {
                countActive = countActive + 1
            }
        }*/
        //if countActive > 1 {
            if GlobalVariables.active[cellIndex] == 0 {
                GlobalVariables.active[cellIndex] = 1
                activeButton.setTitle("ACTIVE", for: .normal)
                activeButton.layer.borderColor = UIColor.orange.cgColor
            } else {
                GlobalVariables.active[cellIndex] = 0
                activeButton.setTitle("INACTIVE", for: .normal)
                activeButton.layer.borderColor = UIColor.red.cgColor
                
            }
        //}
        
        
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
