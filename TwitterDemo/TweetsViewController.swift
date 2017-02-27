//
//  TweetsViewController.swift
//  TwitterDemo
//
//  Created by Matthew Lee on 2/12/17.
//  Copyright © 2017 Matthew Lee. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tweets: [Tweet]!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets) in
            self.tweets = tweets
            self.tableView.reloadData()
            
        }, failure: { (error) in
            print("error: \(error.localizedDescription)")
        })

        // Do any additional setup after loading the view.
        
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
        cell.datelabel.text = tweet.timestampString
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
