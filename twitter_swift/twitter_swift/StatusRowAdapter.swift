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
    var offlineCell : TimelineCell?

    override func cellForItem(item : ModelObject,tableViewController : UITableViewController) -> UITableViewCell?
    {
        let width = tableViewController.tableView.bounds.size.width
        var cell : TimelineCell = tableViewController.tableView.dequeueReusableCellWithIdentifier(self.cellReuseIdentifier) as TimelineCell
        cell.mediaCollection.registerClass(ImageEntityCell.self, forCellWithReuseIdentifier: ImageEntityAdapter().reuseIdentifier)
        let tweet = item as Tweet

        cell.bounds = CGRectMake(0, 0, width, 999)

        self._updateCell(cell, tweet: tweet)
        //NSLog("real cell height of text \"%@\" is %.2f cell height %.2f", cell.tweetText.text, cell.tweetText.bounds.size.height, cell.bounds.size.height)
        return cell
    }

    override func didSelectItem(item : ModelObject, tableViewController : UITableViewController, indexPath : NSIndexPath?)
    {
        // TODO: tweet details
    }

    func _attributedTextForTweet(tweet: Tweet) -> NSAttributedString?
    {
        var value = NSMutableAttributedString(string:tweet.text,attributes:[NSFontAttributeName:UIFont(name: "HelveticaNeue", size: 10.0)])
        if let entityArray = tweet.entities {
            for entity in entityArray {
                value.setAttributes([NSForegroundColorAttributeName: UIColor.blueColor(), NSFontAttributeName:UIFont(name: "HelveticaNeue", size: 10.0)], range: entity.indices)
            }
        }

        return value
    }

    func _activeAreasForTweet(tweet : Tweet, cell : TimelineCell) -> [Entity:AnyObject]!
    {
        var entityMap = [Entity:AnyObject]()
        if let entityArray = tweet.entities {
            let textInput = cell.tweetText
            for entity in entityArray {
                let textRange = textInput.textRangeFromPosition(textInput.positionFromPosition(textInput.beginningOfDocument, offset: entity.indices.location), toPosition: textInput.positionFromPosition(textInput.beginningOfDocument, offset: entity.indices.location + entity.indices.length))
                entityMap[entity] = textRange
            }
        }
        return entityMap
    }

    func _updateCell(cell: TimelineCell, tweet: Tweet)
    {
        cell.setNeedsUpdateConstraints()
        cell.setNeedsLayout()
        cell.layoutIfNeeded()

        cell.userAvatar.url = tweet.user?.profileImageURL
        if let handle = tweet.user?.screenName {
            cell.userHandleLabel.text = "@"+handle
        }
        cell.tweetText.attributedText = self._attributedTextForTweet(tweet)
        cell.timeLabel.text = self.formatTimeInterval(NSDate().timeIntervalSinceDate(tweet.createdAt))
        cell.userNameLabel.text = tweet.user?.name
        cell.widthConstraint.constant = CGRectGetWidth(cell.tweetText.bounds)

        let textSize = cell.tweetText.attributedText.boundingRectWithSize(CGSizeMake(CGRectGetWidth(cell.tweetText.bounds), 999), options:.UsesLineFragmentOrigin, context: nil)

        // TODO: figure out if there is a way to eliminate the need for this
        // magic constant.  I think it represents the scrolling insets of the
        // textView.
        cell.heightConstraint.constant = CGRectGetHeight(textSize) + 30

        cell.setNeedsUpdateConstraints()
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
    }

    override func heightForItem(item: ModelObject, tableViewController: UITableViewController) -> CGFloat
    {
        let width = tableViewController.tableView.bounds.size.width
        if offlineCell == nil {
            offlineCell = tableViewController.tableView.dequeueReusableCellWithIdentifier(self.cellReuseIdentifier) as? TimelineCell
        }

        let tweet = item as Tweet

        offlineCell!.bounds = CGRectMake(0, 0, width, 999)
        self._updateCell(offlineCell!, tweet: tweet)

        var s = offlineCell!.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)

        return s.height + 1
    }

    override func estimatedHeightForItem(item: ModelObject, tableViewController: UITableViewController) -> CGFloat
    {
        return 135.0
    }
}
