//
//  ProfileViewController.swift
//  TwitterDemo
//
//  Created by Matthew Lee on 3/6/17.
//  Copyright © 2017 Matthew Lee. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var userID: Int?
    var tweets: [Tweet]!

    @IBOutlet weak var profileImageVIew: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetsCount: UILabel!
    @IBOutlet weak var followingCount: UILabel!
    @IBOutlet weak var followersCount: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        setUpUser()
        self.profileImageVIew.layer.cornerRadius = 3
        self.profileImageVIew.clipsToBounds = true
        self.profileImageVIew.layer.cornerRadius = 3
        self.profileImageVIew.clipsToBounds = true

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
    }
    
    func setUpUser() {
        TwitterClient.sharedInstance?.getUser(success: { (users: [User]) in
            let user = users[0]
            //most relevant search
            
            
            self.profileImageVIew.setImageWith(user.profileUrl!)
            self.nameLabel.text = user.name!
            self.usernameLabel.text = user.screenname
            self.tweetsCount.text = "\(user.tweetsCount)"
            self.followersCount.text = "\(user.followersCount)"
            self.followingCount.text = "\(user.followingCount)"

        }, failure: { (error: Error) in
            print(error.localizedDescription)
        }, userID: userID!)
        
        TwitterClient.sharedInstance?.userTimeline(success: { (tweets: [Tweet]) in
            print(tweets)
            self.tweets = tweets
            self.tableView.reloadData()
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        }, userID: userID!)
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TwitterCell", for: indexPath) as! TwitterCell
        let tweet = tweets[indexPath.row]
        //cell.tweet = tweet
        cell.descriptionLabel.text = tweet.text!
        cell.retweetCountLabel.text = String(tweet.retweetCount)
        cell.favoriteCountLabel.text = String(tweet.favoritesCount)
        cell.nameLabel.text = tweet.name
        cell.handleLabel.text = tweet.screenname
        cell.profileImageView.setImageWith(tweet.profileUrl!)
        cell.tweetID = tweet.tweetID
        cell.hasRetweeted = tweet.retweet
        cell.hasFavorited = tweet.favorited
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE HH:mm"
        cell.datelabel.text = formatter.string(from: tweet.timestamp!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = tweets {
            return tweets.count
        } else {
            return 0
        }
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
