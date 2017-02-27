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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onRetweet(_ sender: Any) {
        print("tweet ID: \(tweetID)")
        
        self.retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControlState.normal)
        self.retweetCountLabel.textColor = UIColor.green
        
        TwitterClient.sharedInstance?.retweet(success: { (tweet: Tweet) in
            print(tweet.retweetCount)
            self.retweetCountLabel.text = "\(tweet.retweetCount)"
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        }, tweetID: tweetID)
    }
    
    @IBAction func onFavorite(_ sender: Any) {
        print("tweet ID: \(tweetID)")
        
        self.favoriteButton.setImage(UIImage(named: "favor-icon-red"), for: UIControlState.normal)
        self.favoriteCountLabel.textColor = UIColor.red
        
        TwitterClient.sharedInstance?.favorite(success: { (tweet: Tweet) in
            print(tweet.favoritesCount)
            self.favoriteCountLabel.text = "\(tweet.favoritesCount)"
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        }, tweetID: tweetID)
    }
    
}
