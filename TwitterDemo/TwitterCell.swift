//
//  TwitterCell.swift
//  TwitterDemo
//
//  Created by Matthew Lee on 2/12/17.
//  Copyright © 2017 Matthew Lee. All rights reserved.
//

import UIKit

class TwitterCell: UITableViewCell {
    
    var user: User!
    var tweet: Tweet!
    var tweetID: Int = 0
    var hasFavorited: Bool?
    var hasRetweeted: Bool?

    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var datelabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profileImageView.layer.cornerRadius = 3
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 3
        profileImageView.clipsToBounds = true
        
        /**
        if let hasFavorited = hasFavorited {
            self.favoriteButton.setImage(UIImage(named: "favor-icon-red"), for: UIControlState.normal)
            self.favoriteCountLabel.textColor = UIColor.red
        }
        
        if let hasRetweeted = hasRetweeted {
            self.retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControlState.normal)
            self.retweetCountLabel.textColor = UIColor.green
        }
 */
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onRetweet(_ sender: Any) {
        print("tweet ID: \(tweetID)")
        
        TwitterClient.sharedInstance?.retweet(success: { (tweet: Tweet) in
            print(tweet.retweetCount)
            self.retweetCountLabel.text = "\(tweet.retweetCount)"
            self.retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControlState.normal)
            self.retweetCountLabel.textColor = UIColor.green
        }, failure: { (error: Error) in
            //print(error.localizedDescription)
            self.onUnretweet()
        }, tweetID: tweetID)
    }
    
    @IBAction func onFavorite(_ sender: Any) {
        print("tweet ID: \(tweetID)")
        
        TwitterClient.sharedInstance?.favorite(success: { (tweet: Tweet) in
            print(tweet.favoritesCount)
            self.favoriteCountLabel.text = "\(tweet.favoritesCount)"
            self.favoriteButton.setImage(UIImage(named: "favor-icon-red"), for: UIControlState.normal)
            self.favoriteCountLabel.textColor = UIColor.red
            
        }, failure: { (error: Error) in
            //print(error.localizedDescription)
            self.onUnfavorite()
        }, tweetID: tweetID)
    }
    
    func onUnfavorite() {
        TwitterClient.sharedInstance?.unfavorite(success: { (tweet: Tweet) in
            print("unfavorite tweetID")
            self.favoriteCountLabel.text = "\(tweet.favoritesCount)"
            self.favoriteCountLabel.textColor = UIColor.black
            self.favoriteButton.setImage(UIImage(named: "favor-icon"), for: UIControlState.normal)
        }, failure: { (error: Error) in
            print("unfavorite failed. Error code: \(error.localizedDescription)")
        }, tweetID: tweetID)
    }
    
    func onUnretweet() {
        TwitterClient.sharedInstance?.unretweet(success: { (tweet: Tweet) in
            print("unretweet")
            self.retweetCountLabel.text = "\(tweet.retweetCount)"
            self.retweetCountLabel.textColor = UIColor.black
            self.retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControlState.normal)
        }, failure: { (error: Error) in
            print("unretweet failed. Error code: \(error.localizedDescription)")
        }, tweetID: tweetID)
    }
    
    
    
}
