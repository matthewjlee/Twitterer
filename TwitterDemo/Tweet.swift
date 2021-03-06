//
//  Tweet.swift
//  TwitterDemo
//
//  Created by Matthew Lee on 2/12/17.
//  Copyright © 2017 Matthew Lee. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var text: String?
    var timestamp: Date?
    var timestampString: String?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var name: String?
    var screenname: String?
    var profileUrl: URL?
    var tweetID: Int = 0
    var favorited:  Bool = false
    var retweet: Bool = false
    var userID: Int?
    
    init(dictionary: NSDictionary) {
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favorite_count"] as? Int) ?? 0
        tweetID = (dictionary["id"] as? Int) ?? 0
        
        let timestampString = dictionary["created_at"] as? String
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        
        if let timestampString = timestampString {
            timestamp = formatter.date(from: timestampString)
            self.timestampString = formatter.string(from: timestamp!)
        }
        
        let user = dictionary["user"] as! NSDictionary
        userID = dictionary["id"] as? Int
        
        name = user["name"] as? String
        screenname = user["screen_name"] as? String
        screenname = "@" + screenname!;
        let profileUrlString = user["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = URL(string: profileUrlString)
        }
        
        favorited = dictionary["favorited"] as! Bool
        let hasRetweetedString = dictionary["retweeted"] as? String
        if let hasRetweetedString = hasRetweetedString {
            if hasRetweetedString == "tweeted" {
                retweet = true
            } else {
                retweet = false
            }
        }

    }
    
    class func tweetsWithArray (dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]() // this gives Swift style array (one that you can append)
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        
        return tweets
    }
}
