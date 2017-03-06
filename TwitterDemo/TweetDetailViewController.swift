
//
//  TweetDetailViewController.swift
//  TwitterDemo
//
//  Created by Matthew Lee on 3/4/17.
//  Copyright © 2017 Matthew Lee. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {

    var tweet: Tweet?
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var handle: UILabel!
    @IBOutlet weak var tweetDescription: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var favoriteCount: UILabel!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        profileImageView.layer.cornerRadius = 3
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 3
        profileImageView.clipsToBounds = true
        
        name.text = tweet?.name
        handle.text = tweet?.screenname
        tweetDescription.text = tweet?.text
        favoriteCount.text = "\((tweet?.favoritesCount)!)"
        retweetCount.text = "\((tweet?.retweetCount)!)"
        timeLabel.text = tweet?.timestampString
        //dateLabel.text = tweet?.
        profileImageView.setImageWith((tweet?.profileUrl)!)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func replyButton(_ sender: Any) {
    }

    @IBAction func onRetweet(_ sender: Any) {
        print("tweet ID: \((tweet?.tweetID)!)")
        
        TwitterClient.sharedInstance?.retweet(success: { (tweet: Tweet) in
            print(tweet.retweetCount)
            self.retweetCount.text = "\(tweet.retweetCount)"
            self.retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControlState.normal)
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        }, tweetID: (tweet?.tweetID)!)
    }
    
    
    @IBAction func onFavorite(_ sender: Any) {
        print("tweet ID: \((tweet?.tweetID)!)")
        
        TwitterClient.sharedInstance?.favorite(success: { (tweet: Tweet) in
            print(tweet.favoritesCount)
            self.favoriteCount.text = "\(tweet.favoritesCount)"
            self.favoriteButton.setImage(UIImage(named: "favor-icon-red"), for: UIControlState.normal)
            
        }, failure: { (error: Error) in
            //print(error.localizedDescription)
            self.onUnfavorite()
        }, tweetID: (tweet?.tweetID)!)
    }
    
    func onUnfavorite() {
        TwitterClient.sharedInstance?.unfavorite(success: { (tweet: Tweet) in
            print("unfavorite tweetID")
            self.favoriteCount.text = "\(tweet.favoritesCount)"
            self.favoriteButton.setImage(UIImage(named: "favor-icon"), for: UIControlState.normal)
        }, failure: { (error: Error) in
            print("unfavorite failed. Error code: \(error.localizedDescription)")
        }, tweetID: (tweet?.tweetID)!)
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
