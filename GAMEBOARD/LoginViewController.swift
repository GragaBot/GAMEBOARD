//
//  LoginViewController.swift
//  GAMEBOARD
//
//  Created by T on 4/28/18.
//  Copyright © 2018 T. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var sc: UISegmentedControl!
    
    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var loginORegister: UIButton!
    
    @IBAction func scActions(_ sender: Any) {
        if sc.selectedSegmentIndex == 0 {
            userName.isHidden = false
            loginORegister.setTitle("Regist", for: .normal)
        } else{
            userName.isHidden = true
             loginORegister.setTitle("Login", for: .normal)
        }
    }
    
    @IBAction func loginRegist(_ sender: Any) {
        if sc.selectedSegmentIndex == 1{
            handleLogin()
        } else {
            handleRegister()
        }
        
    }
    func handleLogin() {
        if email.text == "" || password.text == "" {
            Config.showAlerts(title: "Oops", message: "Please enter valid values!", handler: nil, controller: self)
        }
        else {
            self.view.endEditing(true)
            let email = self.email.text, password = self.password.text
            API.authAPI.signInWithEmail(withEmail: email!, withPassword: password!, onSuccess: {
                self.loginSuccess()
            }, onEmailNotVerified: {
                Config.showAlerts(title: "Oops!", message: "Please verify your email address first.", handler:nil, controller: self)
            })
        }
    }
    func handleRegister() {
        if email.text == "" || password.text == "" || userName.text == ""
        {
            Config.showAlerts(title: "Oops!", message: "Please enter valid values!", handler: nil, controller: self)
        }
        else {
            self.view.endEditing(true)
            let email = self.email.text! as String, password = self.password.text, name = self.userName.text! as String
            
            API.authAPI.createNewUser(withName: name, withEmail: email, withPassword: password!, onSuccess: {
                Config.showAlerts(title: "Success!", message: "Email was sent, please verify your email address now.", handler: {
                    _ in
                    self.email.text = ""
                    self.password.text = ""
                    self.userName.text = ""
                }, controller: self)
            })
        }
    }
    func loginSuccess() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
        self.present(tabBarController, animated: true, completion: nil)
        print("success")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
        
        userName.clipsToBounds = true
        userName.layer.cornerRadius = userName.bounds.size.height/2
        userName.layer.borderColor = UIColor.white.cgColor
        userName.layer.borderWidth = 3
        
        email.clipsToBounds = true
        email.layer.cornerRadius = email.bounds.size.height/2
        email.layer.borderColor = UIColor.white.cgColor
        email.layer.borderWidth = 3
        
        password.clipsToBounds = true
        password.layer.cornerRadius = password.bounds.size.height/2
        password.layer.borderColor = UIColor.white.cgColor
        password.layer.borderWidth = 3
        
        loginORegister.clipsToBounds = true
        loginORegister.layer.cornerRadius = loginORegister.bounds.size.height/2
        loginORegister.layer.borderColor = UIColor.white.cgColor
        loginORegister.layer.borderWidth = 3
        loginORegister.clipsToBounds = true
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
