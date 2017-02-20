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

}
