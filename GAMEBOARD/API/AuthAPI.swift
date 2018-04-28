//
//  AuthAPI.swift
//  GAMEBOARD
//
//  Created by T on 4/28/18.
//  Copyright © 2018 T. All rights reserved.
//


import Foundation
import FirebaseAuth

class AuthAPI : NSObject {
    
    let userRef = API().userRef
    
    
    // Create new user with Email
    func createNewUser(withName name:String, withEmail email:String, withPassword password: String, onSuccess:@escaping()->Void) {
        Config.showPlainLoading(withStatus: "Registering...")
        Auth.auth().createUser(withEmail: email, password: password, completion: {
            user, error in
            if error != nil {
                Config.showError(withStatus: error!.localizedDescription)
                return
            }
            guard let userID = user?.uid else {
                Config.dismissPlainLoading()
                return
            }
            
            let newUser = Profile.newUser(username: name, userID: userID, email: email)
            Profile.currentUser = newUser
            newUser.sync(onSuccess: {
                Auth.auth().currentUser?.sendEmailVerification(completion: {
                    EmailVError in
                    if EmailVError != nil {
                        Config.showError(withStatus: EmailVError!.localizedDescription)
                        return
                    }
                    DispatchQueue.main.async {
                        Config.dismissPlainLoading()
                        try! Auth.auth().signOut()
                        onSuccess()
                    }
                })
            }, onError: {
                error in
                print(error.localizedDescription)
                Config.dismissPlainLoading()
                return
            })
        })
    }
    
    // Sign in with Email
    func signInWithEmail(withEmail email:String, withPassword password: String, onSuccess:@escaping()->Void, onEmailNotVerified: @escaping()->Void) {
        Config.showPlainLoading(withStatus: "Logging in...")
        Auth.auth().signIn(withEmail: email, password: password, completion: {
            user, error in
            if error != nil {
                Config.showError(withStatus: error!.localizedDescription)
                return
            }
            guard let uid = user?.uid else {
                Config.dismissPlainLoading()
                return
            }
            if user?.isEmailVerified == false {
                Config.dismissPlainLoading()
                self.authLogOut()
                onEmailNotVerified()
                return
            }
            
            API.userAPI.fetchUserInfo(withID: uid, completion: {
                profile in
                if let fetchedProfile = profile {
                    Profile.currentUser = fetchedProfile
                    
                    DispatchQueue.main.async {
                        Config.dismissPlainLoading()
                        onSuccess()
                    }
                    
                }
                
            })
        })
    }
    
   
    // Check if currentUser is nil
    func checkCurrentUser() -> Bool {
        
        if Auth.auth().currentUser != nil {
            return true
        }
        else {
            return false
        }
        
    }
    
    // LogOut
    func authLogOut() {
        try! Auth.auth().signOut()
    }
    
    
    // Send Reset Password Email
    func sendPasswordReset(withEmail email:String, onSuccess: @escaping()-> Void) {
        
        Auth.auth().sendPasswordReset(withEmail: email, completion: {
            error in
            if error != nil {
                Config.showError(withStatus: error!.localizedDescription)
                return
            }
            onSuccess()
        })
        
    }
    
}

