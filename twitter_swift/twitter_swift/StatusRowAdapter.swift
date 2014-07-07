//
//  StatusRowAdapter.swift
//  MiniPlatform
//
//  Created by Robert Diamond on 6/27/14.
//  Copyright (c) 2014 Robert Diamond. All rights reserved.
//

import MiniPlatform
import UIKit

class StatusRowAdapter : RowAdapter {
    override func cellForItem(item : ModelObject,tableViewController : UITableViewController) -> UITableViewCell?
    {
        var cell : TimelineCell = tableViewController.tableView.dequeueReusableCellWithIdentifier(self.cellReuseIdentifier) as TimelineCell
        let tweet = item as Tweet
        cell.userAvatar.url = tweet.user?.profileImageURL
        cell.tweetTextLabel.attributedText = self._attributedTextForTweet(tweet)

        return cell
    }

    override func didSelectItem(item : ModelObject,tableViewController : UITableViewController)
    {
        // TODO: tweet details
    }

    func _attributedTextForTweet(tweet: Tweet) -> NSAttributedString?
    {
        var value = NSMutableAttributedString(string:tweet.text)
        if let entityArray = tweet.entities {
            for entity in entityArray {
                value.setAttributes([NSForegroundColorAttributeName: UIColor.blueColor()], range: entity.indices)
            }
        }

        return value
    }
}
