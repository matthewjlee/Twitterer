//
//  User.swift
//  TwitterDemo
//
//  Created by Matthew Lee on 2/12/17.
//  Copyright © 2017 Matthew Lee. All rights reserved.
//

import UIKit

class User: NSObject {

    var name: String?
    var screenname: String?
    var profileUrl: URL?
    var tagline: String?
    var userID: Int?
    var tweetsCount: Int?
    var followingCount: Int?
    var followersCount: Int?
    
    var dictionary: NSDictionary?
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String //attempt to cast into String (if it's not there will be nil)
        screenname = dictionary["screen_name"] as? String
        
        let profileUrlString = dictionary["profile_image_url_https"] as? String //this could potentially not exist
        if let profileUrlString = profileUrlString {
            profileUrl = URL(string: profileUrlString)
        }
        
        tagline = dictionary["description"] as? String
        userID = dictionary["id"] as? Int
        
        tweetsCount = (dictionary["statuses_count"] as? Int) ?? 0
        followingCount = (dictionary["friends_count"] as? Int) ?? 0
        followersCount = (dictionary["followers_count"] as? Int) ?? 0
    }
    
    static let userDidLogoutNotification = "UserDidLogout"
    static var _currentuser: User?
    class var currentUser: User? {
        get {
            if _currentuser == nil {
                let defaults = UserDefaults.standard
            
                let userData = defaults.object(forKey: "currentUserData") as? Data
            
                if let userData = userData {
                    //let dictionary = try! JSONSerialization.data(withJSONObject: userData, options: []) as! NSDictionary
                    let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! NSDictionary
                    _currentuser = User(dictionary: dictionary)
                }
            }
            return _currentuser
        }
        set (user) {
            _currentuser = user
            
            let defaults = UserDefaults.standard
            
            //if user does exist, then create data that turns it into what it started off as
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])

                defaults.set(data, forKey: "currentUserData")
            } else {
                defaults.removeObject(forKey: "currentUserData")
            }
            defaults.synchronize()
        }
    }
    
    class func usersInArray(dictionaries: [NSDictionary]) -> [User] {
        var users = [User]()
        
        for dictionary in dictionaries {
            let user = User(dictionary: dictionary)
            users.append(user)
        }
        
        return users
    }
    
}
