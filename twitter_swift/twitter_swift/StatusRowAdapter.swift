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

        self._updateCell(cell, tweet: tweet)
        return cell
    }

    override func didSelectItem(item : ModelObject, tableViewController : UITableViewController, indexPath : NSIndexPath?)
    {
        // TODO: tweet details
    }

    func _attributedTextForTweet(tweet: Tweet) -> NSAttributedString?
    {
        var value = NSMutableAttributedString(string:tweet.text,attributes:[NSFontAttributeName:UIFont(name: "HelveticaNeue", size: 11.0)])
        if let entityArray = tweet.entities {
            for entity in entityArray {
                value.setAttributes([NSForegroundColorAttributeName: UIColor.blueColor()], range: entity.indices)
            }
        }

        return value
    }

    func _updateCell(cell: TimelineCell, tweet: Tweet)
    {
        cell.userAvatar.url = tweet.user?.profileImageURL
        if let handle = tweet.user?.screenName {
            cell.userHandleLabel.text = "@"+handle
        }
        cell.tweetTextLabel.attributedText = self._attributedTextForTweet(tweet)
        cell.timeLabel.text = self.formatTimeInterval(NSDate().timeIntervalSinceDate(tweet.createdAt))
        cell.userNameLabel.text = tweet.user?.name
    }

    override func heightForItem(item: ModelObject, tableViewController: UITableViewController) -> CGFloat
    {
        var offlineCell = tableViewController.tableView.dequeueReusableCellWithIdentifier(self.cellReuseIdentifier) as TimelineCell
        offlineCell.setNeedsUpdateConstraints()
        offlineCell.updateConstraintsIfNeeded()

        let tweet = item as Tweet
        self._updateCell(offlineCell, tweet: tweet)

        offlineCell.bounds = CGRect(x: 0, y: 0, width: tableViewController.tableView.bounds.size.width, height: CGRectGetHeight(offlineCell.bounds))
        offlineCell.setNeedsLayout()
        offlineCell.layoutIfNeeded()

        return offlineCell.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height + 1
    }
}
