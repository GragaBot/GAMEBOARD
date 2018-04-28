//
//  ViewController.swift
//  GAMEBOARD
//
//  Created by T on 1/13/18.
//  Copyright © 2018 T. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AMOUNT", for: indexPath) as! PrizeCollectionViewCell
        
        cell.prize.text = String(indexPath.row)
        cell.exact.text = String(2 << (indexPath.row-1))
   
        
        
        return cell
    }
  
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
        if playerName.selectedSegmentIndex != playerName2.selectedSegmentIndex {
            print("good")
            let result = 2 << (indexPath.row-1)
            
            scoreTemp = result
            
            self.visualEffect.isHidden = false

            animateIn()

            //handleMath(prize: result)
        }
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return playerName.numberOfSegments
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 19999
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(row-9999)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
      
        var log = GlobalVariables.playerList[component] + " " + String(row - 9999 - GlobalVariables.playerScores[component])
        
        GlobalVariables.playerScores[component] = row - 9999
        
        log = log + " SCORE BOARD: " + String(describing: GlobalVariables.playerScores)
        GlobalVariables.gameLog.append(log)
        print(log)
        
        varifySum()
    }
    
    func varifySum(){
        var sum = 0
        for index in 0...GlobalVariables.playerScores.count-1{
            sum = sum + GlobalVariables.playerScores[index]
        }
        
        if sum != 0 {
            scoreBoard.alpha = 0.3
            GlobalVariables.scoreFlag.append(false)
        } else {
            scoreBoard.alpha = 1
            GlobalVariables.scoreFlag.append(true)
        }
    }

    
   
    
    @IBOutlet weak var testSegment: CustomSegmentedControl!
    
    
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var scoreBoard: UIPickerView!
    @IBOutlet weak var playerName: UISegmentedControl!
    
    @IBOutlet weak var visualEffect: UIVisualEffectView!
    @IBOutlet weak var submitAmount: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var changeView: UISegmentedControl!
    @IBOutlet weak var amount: UICollectionView!
    @IBOutlet weak var playerName2: UISegmentedControl!
    var effect:UIVisualEffect!
    var scoreTemp: Int!
    var activePlayerNumbers: Int!

    @IBOutlet var check: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
  
        
        effect = visualEffect.effect
        visualEffect.effect = nil
        check.layer.cornerRadius = 10
        self.visualEffect.isHidden = true
        
        scoreBoard.dataSource=self
        scoreBoard.delegate = self
        scoreBoard.showsSelectionIndicator = false
        
        
        amount.dataSource = self
        amount.delegate = self
        submitAmount.keyboardType = UIKeyboardType.numberPad
        
        
        submitAmount.attributedPlaceholder = NSAttributedString(string: "Enter Amount Here...", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        
        playerName.layer.cornerRadius = playerName.frame.height/2
        playerName.layer.borderColor = UIColor.red.cgColor
        playerName.layer.borderWidth = 1
        playerName.clipsToBounds = true
        playerName2.layer.cornerRadius = playerName.frame.height/2
        playerName2.layer.borderColor = UIColor.red.cgColor
        playerName2.layer.borderWidth = 1
        playerName2.clipsToBounds = true
        
        
        
        
        navigationItem.title = "SCORE BOARD"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]

        playerName.setTitle(GlobalVariables.playerList[0], forSegmentAt: 0)
        playerName.setTitle(GlobalVariables.playerList[1], forSegmentAt: 1)
        playerName2.setTitle(GlobalVariables.playerList[0], forSegmentAt: 0)
        playerName2.setTitle(GlobalVariables.playerList[1], forSegmentAt: 1)
      
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector (self.doneClicked) )
        toolBar.setItems([flexibleSpace,doneButton], animated: false)
        submitAmount.inputAccessoryView = toolBar
        
        
        
        if GlobalVariables.playerList.count>2{
            for index in 2 ... GlobalVariables.playerList.count-1{
                playerName.insertSegment(withTitle: GlobalVariables.playerList[index], at: index, animated: false)
                playerName2.insertSegment(withTitle: GlobalVariables.playerList[index], at: index, animated: false)
            }
            
        }
        activePlayerNumbers = 0
        var flag = false
        for index in 0...GlobalVariables.active.count-1 {
            if GlobalVariables.active[index] == 0 {
                playerName2.setEnabled(false, forSegmentAt: index)
                playerName.setEnabled(false, forSegmentAt: index)

            } else {
                if flag == false {
                    playerName.selectedSegmentIndex = index
                    flag = true
                }
                activePlayerNumbers = activePlayerNumbers + 1
            }
        }
        if activePlayerNumbers == 0 || activePlayerNumbers == 1 {
            submitButton.isEnabled = false
            amount.allowsSelection = false
        } else {
            submitButton.isEnabled = true
            amount.allowsSelection = true
        }
        
        playerName2.insertSegment(withTitle: "自摸！", at: playerName2.numberOfSegments, animated: false)
        playerName2.selectedSegmentIndex = playerName2.numberOfSegments - 1
        
        for index in 0...playerName.numberOfSegments-1{
            
            scoreBoard.selectRow(9999+GlobalVariables.playerScores[index], inComponent: index, animated: false)
            
        }
        
        submitButton.layer.cornerRadius = submitButton.bounds.size.width/2
        submitButton.clipsToBounds = true
    }
    @objc func doneClicked(){
        view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func handleMath(prize: Int){
        
        let p1 =         playerName.selectedSegmentIndex
        
        let p2 =         playerName2.selectedSegmentIndex
        
        let result = prize
        let totalPlayer = activePlayerNumbers
        
        if p2 != playerName2.numberOfSegments-1 {
            let p1Score = scoreBoard.selectedRow(inComponent: p1)-9999 + result
            let p2Score = scoreBoard.selectedRow(inComponent: p2)-9999 - result
            
            scoreBoard.selectRow(9999+p1Score, inComponent: playerName.selectedSegmentIndex, animated: false)
            
            scoreBoard.selectRow(9999+p2Score, inComponent: playerName2.selectedSegmentIndex, animated: false)
            GlobalVariables.playerScores[p1] = p1Score
            GlobalVariables.playerScores[p2] = p2Score
            
            
        } else {
            
            let p1Score = scoreBoard.selectedRow(inComponent: p1)-9999 + (totalPlayer!-1)*result
            print("here" , p1Score)
            
            scoreBoard.selectRow(9999+p1Score, inComponent: playerName.selectedSegmentIndex, animated: false)
            GlobalVariables.playerScores[p1] = p1Score
            
            
            for index in 0...playerName.numberOfSegments-1 {
                if index != p1 && GlobalVariables.active[index] != 0{
                    let p2Score = scoreBoard.selectedRow(inComponent: index)-9999 - result
                    scoreBoard.selectRow(9999+p2Score, inComponent: index, animated: false)
                    
                    GlobalVariables.playerScores[index] = p2Score
                    
                }
            }
            
        }
    }
    @IBAction func submitPrize(_ sender: UIButton) {
        if playerName.selectedSegmentIndex != playerName2.selectedSegmentIndex {
            
            if submitAmount != nil && submitAmount.text != "" {
                
                scoreTemp = Int(submitAmount.text!)!
                self.visualEffect.isHidden = false
                animateIn()
            }
            
        }
        
    
   
    }
    
    @IBOutlet weak var customView: UIView!
    @IBAction func changeView(_ sender: Any) {
        if changeView.selectedSegmentIndex == 0 {
            amount.isHidden = true
            customView.isHidden = false
        }
        
        if changeView.selectedSegmentIndex == 1 {
            amount.isHidden = false
            customView.isHidden = true
        }
        
    }
    
    
    @IBAction func testSegment(_ sender: Any) {
        if testSegment.selectedSegmentIndex == 0 {
            amount.isHidden = true
            customView.isHidden = false
        }
        
        if testSegment.selectedSegmentIndex == 1 {
            amount.isHidden = false
            customView.isHidden = true
        }
    }
    
    @IBAction func varifyAmount(_ sender: Any) {
        
        handleMath(prize: scoreTemp)
        animateOut()
        
    }
    
    @IBAction func dismissView(_ sender: Any) {
        animateOut()
        GlobalVariables.gameLog.remove(at: GlobalVariables.gameLog.count-1)
        GlobalVariables.scoreFlag.remove(at: GlobalVariables.scoreFlag.count-1)
    }
    
    
    func animateIn(){
        self.view.addSubview(check)
        check.center = self.view.center
        check.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        check.alpha = 0
        
        UIView.animate(withDuration: 0.4){
            self.visualEffect.effect = self.effect
            self.check.alpha = 1
            self.check.transform = CGAffineTransform.identity
        }
        
        if playerName2.selectedSegmentIndex != playerName2.numberOfSegments-1 {
            
            var temp = playerName.titleForSegment(at: playerName.selectedSegmentIndex)! + " wins " + String(scoreTemp) + " points, " + playerName2.titleForSegment(at: playerName2.selectedSegmentIndex)! + " loses " + String(scoreTemp) + " points."
            message.text = String(temp)
            
            temp = temp + " PREVIOUS SCORE BOARD: " + String(describing: GlobalVariables.playerScores)
            GlobalVariables.gameLog.append(temp)
            varifySum()
        } else {
            var losers = " "
            for index in 0...playerName.numberOfSegments-1{
                
                if GlobalVariables.active[index] == 1 && index != playerName.selectedSegmentIndex{
                    losers = losers + GlobalVariables.playerList[index] + " "
                }
            }
            var temp = playerName.titleForSegment(at: playerName.selectedSegmentIndex)! + " wins " + String(scoreTemp * (activePlayerNumbers - 1)) + " points, " + losers + " each loses " + String(scoreTemp) + " points."
            
            message.text = String(temp)
            
            temp = temp + " PREVIOUS SCORE BOARD: " + String(describing: GlobalVariables.playerScores)
            
            GlobalVariables.gameLog.append(temp)
            varifySum()


            
        }
        
        
        
    }
    
    func animateOut(){
        self.visualEffect.isHidden = true

        UIView.animate(withDuration: 0.3, animations: {
            self.check.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.check.alpha = 0
            self.visualEffect.effect = nil
        }) { (sucess: Bool) in
            self.check.removeFromSuperview()
        }
    }

}

