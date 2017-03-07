//
//  TweetsViewController.swift
//  TwitterDemo
//
//  Created by Matthew Lee on 2/12/17.
//  Copyright © 2017 Matthew Lee. All rights reserved.
//

import UIKit
import AFNetworking

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tweets: [Tweet]!
    
    @IBOutlet weak var tableView: UITableView!
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        /**
        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets) in
            self.tweets = tweets
            self.tableView.reloadData()
            
        }, failure: { (error) in
            print("error: \(error.localizedDescription)")
        })
        */
        
        onRefresh()
        
        refreshControl.addTarget(self, action: #selector(onRefresh), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        

        // Do any additional setup after loading the view.
        
    }
    
    func onRefresh() {
        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets) in
            self.tweets = tweets
            self.tableView.reloadData()
            
        }, failure: { (error) in
            print("error: \(error.localizedDescription)")
        })
        refreshControl.endRefreshing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogoutButton(_ sender: Any) {
        TwitterClient.sharedInstance?.logout()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TwitterCell") as! TwitterCell
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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let sender = sender as? UITableViewCell {
            let cell = sender
            let indexPath = tableView.indexPath(for: cell)
            let tweet = tweets![indexPath!.row]
            
            let detailViewController = segue.destination as! TweetDetailViewController
            detailViewController.tweet = tweet
            
            print("\(tweet.tweetID)")
        }
        
        if let sender = sender as? UIButton {
            if let superviewImage = sender.superview {
                if let cell = superviewImage.superview as? TwitterCell {
                    let profileViewController = segue.destination as! ProfileViewController
                    //profileViewController.userID = User._currentuser?.userID
        
                    let indexPath = tableView.indexPath(for: cell)
                    let tweet = tweets![indexPath!.row]
                    
                    profileViewController.userID = tweet.userID
                }
            }
            
            
        }
    }

}
