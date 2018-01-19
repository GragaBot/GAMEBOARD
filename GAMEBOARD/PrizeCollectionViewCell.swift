//
//  PrizeCollectionViewCell.swift
//  GAMEBOARD
//
//  Created by T on 1/13/18.
//  Copyright © 2018 T. All rights reserved.
//

import UIKit

class PrizeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var exact: UILabel!
    @IBOutlet weak var prize: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        prize.layer.cornerRadius = prize.frame.height/2
        prize.layer.borderWidth = 3
        prize.layer.borderColor = UIColor.lightText.cgColor
        prize.clipsToBounds = true
    }
}
