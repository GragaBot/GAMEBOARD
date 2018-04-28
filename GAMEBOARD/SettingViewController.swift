//
//  SettingViewController.swift
//  GAMEBOARD
//
//  Created by T on 1/13/18.
//  Copyright © 2018 T. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    
    @IBOutlet weak var visualEffect: UIVisualEffectView!
   
    @IBOutlet var editName: UIView!
    
    @IBOutlet weak var donebutton: UIButton!
    
    @IBOutlet weak var nameInput: UITextField!
    
    @IBOutlet weak var PlayerList: UITableView!
    var effect:UIVisualEffect!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        effect = visualEffect.effect
        visualEffect.effect = nil
        editName.layer.cornerRadius = 10
        self.visualEffect.isHidden = true
        donebutton.layer.borderWidth = 3
        donebutton.layer.borderColor = UIColor.red.cgColor
        donebutton.layer.cornerRadius = donebutton.bounds.size.height/2
        donebutton.clipsToBounds = true
        comfirmReset.backgroundColor = UIColor.orange
        comfirmReset.layer.borderWidth = 3
        comfirmReset.layer.borderColor = UIColor.red.cgColor
        comfirmReset.layer.cornerRadius = comfirmReset.bounds.size.height/2
        comfirmReset.clipsToBounds = true
        cancel.backgroundColor = UIColor.red
        cancel.layer.borderWidth = 3
        cancel.layer.borderColor = UIColor.orange.cgColor
        cancel.layer.cornerRadius = cancel.bounds.size.height/2
        cancel.clipsToBounds = true
        
        
        navigationItem.title = "SETTINGS"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]

        navigationController?.navigationBar.barTintColor = UIColor.red
        
        
        PlayerList.delegate=self
        PlayerList.dataSource=self
        // Do any additional setup after loading the view.
        
        
    }
    
    func animateIn(){
        self.view.addSubview(editName)
        editName.center = self.view.center
        editName.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        editName.alpha = 0
        
        UIView.animate(withDuration: 0.4){
            self.visualEffect.effect = self.effect
            self.editName.alpha = 1
            self.editName.transform = CGAffineTransform.identity
            
           
        }
        donebutton.isHidden = false
        nameInput.isHidden = false
    }
    
    func animateOut(){
        UIView.animate(withDuration: 0.3, animations: {
            self.editName.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.editName.alpha = 0
            self.visualEffect.effect = nil
        }) { (sucess: Bool) in
            self.editName.removeFromSuperview()
        }
    }
    
  
    
    @objc func doneClicked(){
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func AddPlayer(_ sender: UIBarButtonItem) {
        //GlobalVariables.playerList.append("PLAYER")
        var length = String(GlobalVariables.playerList.count + 1)
        length = "Player" + length
        GlobalVariables.playerList.append(length)

        GlobalVariables.playerScores.append(0)
        GlobalVariables.active.append(1)
        print(GlobalVariables.playerList)
        self.PlayerList.reloadData()
        GlobalVariables.gameLog[0] = String(describing: GlobalVariables.playerList)
    }
    
    @IBOutlet weak var comfirmReset: RoundedButton!
    
    @IBOutlet weak var cancel: RoundedButton!
    @IBAction func prompInputView(_ sender: Any) {
        animateIn()
        self.visualEffect.isHidden = false
        self.comfirmReset.isHidden = true
        
    }
    
    
    @IBAction func dismissInputView(_ sender: Any) {
        if nameInput.text != "" {
            
            animateOut()
            self.visualEffect.isHidden = true
            
            let cell = PlayerList.cellForRow(at: GlobalVariables.cellindex) as! SettingTableViewCell
            
            cell.done.setTitle(nameInput.text, for: .normal)
            
            GlobalVariables.playerList[cell.cellIndex] = cell.done.title(for: .normal)!
            
            GlobalVariables.gameLog[0] = String(describing: GlobalVariables.playerList)
        }
        
        
    }
    
    @IBAction func resetSetting(_ sender: Any) {
        self.visualEffect.isHidden = false
        animateIn()
        donebutton.isHidden = true
        nameInput.isHidden = true
        comfirmReset.isHidden = false


    }
    @IBAction func doRest(_ sender: Any) {
        animateOut()
        self.visualEffect.isHidden = true
        GlobalVariables.active =  [1,1,1,1]
        GlobalVariables.playerScores = [0, 0, 0, 0]
        GlobalVariables.playerList = ["Player1", "Player2", "Player3","Player4"]
        GlobalVariables.gameLog = [String(describing: GlobalVariables.playerList)]
        GlobalVariables.scoreFlag = [true]
        self.PlayerList.reloadData()
        
    }
    
    @IBAction func cancelReset(_ sender: Any) {
        animateOut()
        self.visualEffect.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GlobalVariables.playerList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PlayerList.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! SettingTableViewCell
       
        
        cell.backgroundColor = UIColor.white
        cell.done.setTitle(GlobalVariables.playerList[indexPath.row], for: .normal)
        cell.done.layer.cornerRadius = cell.done.bounds.size.height/2
        cell.done.clipsToBounds = true
        if GlobalVariables.active[indexPath.row] == 1{
            cell.activeButton.backgroundColor = UIColor.white
        }
        cell.activeButton.layer.cornerRadius = cell.activeButton.bounds.size.height/2
        cell.activeButton.clipsToBounds = true
        cell.activeButton.setTitle("ACTIVE", for: .normal)
        if GlobalVariables.active[indexPath.row] == 0 {
            cell.activeButton.setTitle("INACTIVE", for: .normal)
            cell.activeButton.layer.borderColor = UIColor.red.cgColor
        } else {
            cell.activeButton.setTitle("ACTIVE", for: .normal)
            cell.activeButton.layer.borderColor = UIColor.orange.cgColor
            
        }
        
        cell.cellIndex = indexPath.row
        cell.indPath = indexPath
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete {
            if GlobalVariables.playerList.count>2{
                GlobalVariables.playerList.remove(at: indexPath.row)
                GlobalVariables.playerScores.remove(at: indexPath.row)
                GlobalVariables.active.remove(at: indexPath.row)
                
                GlobalVariables.gameLog[0] = String(describing: GlobalVariables.playerList)
                self.PlayerList.reloadData()
            }
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return(true)
    }
}

struct GlobalVariables {
    static var playerList: [String] = ["Player1", "Player2", "Player3","Player4"]
    static var playerScores: [Int] = [0, 0, 0, 0]
    static var active: [Int] = [1,1,1,1]
    static var cellindex : IndexPath!
    static var gameLog : [String] = [String(describing: playerList)]
    static var scoreFlag: [Bool] = [true]
}

class RoundedButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        let radius: CGFloat = self.bounds.size.height / 2.0
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}
