//
//  LoginTextField.swift
//  GAMEBOARD
//
//  Created by T on 4/28/18.
//  Copyright © 2018 T. All rights reserved.
//

import UIKit
class LoginTextField: UITextField {
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    override func layoutSubviews(){
        super.layoutSubviews()
        
        self.layer.borderColor = UIColor(white:231/255, alpha:1).cgColor
        self.layer.borderWidth = 1
    }
    
    override func textRect(forBounds bounds: CGRect) ->CGRect{
        return bounds.insetBy(dx:8, dy:7)
    }
    
    override func editingRect(forBounds bounds:CGRect)-> CGRect{
        return textRect(forBounds: bounds)
    }
    
    
}
