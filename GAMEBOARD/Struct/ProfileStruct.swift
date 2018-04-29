//
//  ProfileStruct.swift
//  GAMEBOARD
//
//  Created by T on 4/28/18.
//  Copyright © 2018 T. All rights reserved.
//

import UIKit
import SVProgressHUD

class Profile {
    let userID:String?
    var email:String
    var username:String
    var friends:[String]?
    var followBrands:[String]?
    var profilePicUrl:URL?
    var backgroundPictureUrl: URL?
    var bio: String?
    var posts:[String]?


    static var currentUser:Profile?
    
    init(username:String, email:String,userID:String,  friends:[String]?, posts:[String]?, profilePicUrl:URL?, backgroundPictureUrl: URL?, bio: String?) {
        self.username = username
        self.userID = userID
        self.email = email
        self.friends = friends
        self.profilePicUrl = profilePicUrl
        self.backgroundPictureUrl = backgroundPictureUrl
        self.bio = bio
        self.posts = posts

        // Check in upon login
        //It's the local time, later it should be a world time and can't be changed from the user's calendar
    }
    // Used during register
    static func newUser(username:String!,userID:String!, email:String!) -> Profile {
        return Profile(username: username, email:email, userID: userID, friends: [String](),posts: [String](), profilePicUrl: nil, backgroundPictureUrl: nil, bio: nil)
    }
    
    // Used during login
    static func initWithUserID(userID:String , profileDict: [String:Any]) -> Profile? {
        let profile = Profile.newUser(username: "Default", userID: userID, email: "Default")
        
        //fetch username,email,raffleTickets,checkinCount,followers,followings, brands,posts, picture
        var friendStr = [String]()
        var postStr = [String]()
        
        if let email = profileDict["email"] as? String {
            profile.email = email
        }
        if let username = profileDict["username"] as? String {
            profile.username = username
        }
        
        
        if let friends = profileDict["friends"] as? [String:Bool] {
            for tempfollowers in friends {
                friendStr.append(tempfollowers.key)
            }
            profile.friends = friendStr
        }
      
        if let imgUrlString = profileDict["profilePicUrl"] as? String {
            profile.profilePicUrl = URL(string: imgUrlString)
        }
        
        if let bgimgUrlString = profileDict["backgroundPictureUrl"] as? String {
            profile.backgroundPictureUrl = URL(string:bgimgUrlString)
        }
        if let bio = profileDict["bio"] as? String{
            profile.bio = bio
        }
        
        if let posts = profileDict["posts"] as? [String:Bool] {
            for some in posts {
                postStr.append(some.key)
            }
            profile.posts = postStr
        }
        
        return profile
    }
    // put all info into dict
    func dictValue() -> [String:Any] {
        
        var profileDict:[String:Any] = [:]
        //fetch userID,username,email,tickets,checkInCount,followers,following, followBrands,posts, picture
        var friendDB = [String:Bool]()
        var postDB = [String:Bool]()
        
        //profileDict["userID"] = userID
        profileDict["username"] = username
        profileDict["email"] = email
        if let postnew = posts {
            for postStr in postnew {
                postDB[postStr] = true
                
            }
            profileDict["posts"] = postDB
        }
        if let friendsnew = friends {
            for friendStr in friendsnew {
                friendDB[friendStr] = true
            }
            profileDict["friends"] = friendDB
        }
        
        if let postnew = posts {
            for postStr in postnew {
                postDB[postStr] = true
                
            }
            profileDict["posts"] = postDB
        }
        profileDict["bio"] = bio
      
        if let profilepicurl = profilePicUrl {
            profileDict["profilePicUrl"] = "\(profilepicurl)"
        }
        if let backgroundpiculr = backgroundPictureUrl {
            profileDict["backgroundPictureUrl"] = "\(backgroundpiculr)"
        }
        return profileDict
    }
    //sync the user profile to database
    func sync(onSuccess: @escaping ()->Void, onError: @escaping (Error)->Void) {
        
        API.userAPI.uploadToDatabase(withID: userID!, dictValue: dictValue(), onSuccess: onSuccess, onError: {
            error in
            onError(error)
        })
        
    }

}


