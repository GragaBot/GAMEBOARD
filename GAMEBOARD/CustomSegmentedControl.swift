//
//  CustomSegmentedControl.swift
//  GAMEBOARD
//
//  Created by T on 1/18/18.
//  Copyright © 2018 T. All rights reserved.
//

import UIKit

@IBDesignable
class CustomSegmentedControl: UIControl {
    var buttons = [UIButton]()
    var selector: UIView!
    var selectedSegmentIndex = 0
    
    @IBInspectable
    var borderWidth: CGFloat = 0{
        didSet{
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable
    var borderColor: UIColor = UIColor.clear{
        didSet{
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable
    var commaSeparatedButtonTitles: String = ""{
        didSet{
            updateView()
        }
    }
    
    @IBInspectable
    var textColor: UIColor = .lightGray {
        didSet{
            updateView()
        }
    }
    @IBInspectable
    var selectorColor: UIColor = .red{
        didSet{
            updateView()
        }
    }
    @IBInspectable
    var selectorTextColor: UIColor = .white{
        didSet{
            updateView()
        }
    }
    
    
    func updateView(){
        buttons.removeAll()
        subviews.forEach { $0.removeFromSuperview()
        }
        let buttonTitles = GlobalVariables.playerList
        
        if commaSeparatedButtonTitles == "PLAYERLIST"{
            for buttonTitle in buttonTitles{
                let button = UIButton(type: .system)
                button.setTitle(buttonTitle, for: .normal)
                button.setTitleColor(textColor, for: .normal)
                button.addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)
                buttons.append(button)
            }
            /*
            let button = UIButton(type: .system)
            button.setTitle(commaSeparatedButtonTitles, for: .normal)
            button.titleLabel?.textAlignment = NSTextAlignment.center
            button.addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)
            buttons.append(button)*/
        } else {
            let buttonTitles = commaSeparatedButtonTitles.components(separatedBy: ",")
            for buttonTitle in buttonTitles{
                let button = UIButton(type: .system)
                button.setTitle(buttonTitle, for: .normal)
                button.setTitleColor(textColor, for: .normal)
                button.titleLabel?.textAlignment = NSTextAlignment.center

                
                button.addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)
                buttons.append(button)
            }
            
        }
        
        
        buttons[0].setTitleColor(selectorTextColor, for: .normal)
        let selectorWidth = frame.width/CGFloat(buttons.count)
        selector = UIView(frame: CGRect(x: 0, y: 0, width: selectorWidth, height: frame.height))
        selector.layer.cornerRadius = frame.height/2
        selector.backgroundColor = selectorColor
        addSubview(selector)
        
        let sv = UIStackView(arrangedSubviews: buttons)
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fillProportionally
        addSubview(sv)
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        sv.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        sv.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        sv.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true


    }
    
    override func draw(_ rect: CGRect) {
        layer.cornerRadius = frame.height/2
    }
    
    @objc func buttonTapped(button: UIButton){
        for (buttonIndex, btn) in buttons.enumerated() {
            btn.setTitleColor(textColor, for: .normal)
            if btn == button {
                selectedSegmentIndex = buttonIndex
                let selectorStartPosition = frame.width / CGFloat(buttons.count) * CGFloat(buttonIndex)
                UIView.animate(withDuration: 0.3, animations: {
                    self.selector.frame.origin.x = selectorStartPosition
                    
                })
                btn.setTitleColor(selectorTextColor, for: .normal)

            }
        }
        sendActions(for: .valueChanged)
    }
    
}
