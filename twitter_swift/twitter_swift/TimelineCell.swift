//
//  TimelineCell.swift
//  twitter_swift
//
//  Created by Robert Diamond on 6/6/14.
//  Copyright (c) 2014 Robert Diamond. All rights reserved.
//

import MiniPlatform
import UIKit

class TimelineCell : UITableViewCell {
    
    @IBOutlet var userAvatar: TFNCachedImageView
    @IBOutlet var userNameLabel: UILabel
    @IBOutlet var userHandleLabel: UILabel
    @IBOutlet var timeLabel: UILabel
    @IBOutlet var replyButton: UIButton
    @IBOutlet var retweetButton: UIButton
    @IBOutlet var favoriteButton: UIButton
    @IBOutlet var followButton: UIButton
    @IBOutlet var tweetText : UITextView

    override func touchesEnded(touches: NSSet!, withEvent event: UIEvent!)
    {
        NSLog("touches %@ event %@", touches, event)
        super.touchesEnded(touches, withEvent: event)
    }
}
