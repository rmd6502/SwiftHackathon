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
        var cell : TimelineCell = tableViewController.tableView.dequeueReusableCellWithIdentifier(self.cellReuseIdentifier) as TimelineCell
        let tweet = item as Tweet

        cell.bounds = CGRect(x: 0, y: 0, width: tableViewController.tableView.bounds.size.width, height: CGRectGetHeight(cell.bounds))
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
        cell.userAvatar.url = tweet.user?.profileImageURL
        if let handle = tweet.user?.screenName {
            cell.userHandleLabel.text = "@"+handle
        }
        cell.tweetText.attributedText = self._attributedTextForTweet(tweet)
        cell.timeLabel.text = self.formatTimeInterval(NSDate().timeIntervalSinceDate(tweet.createdAt))
        cell.userNameLabel.text = tweet.user?.name
        cell.setNeedsUpdateConstraints()
        cell.setNeedsLayout()
        cell.activeAreas = self._activeAreasForTweet(tweet, cell: cell)
    }

    override func heightForItem(item: ModelObject, tableViewController: UITableViewController) -> CGFloat
    {
        if offlineCell == nil {
            offlineCell = tableViewController.tableView.dequeueReusableCellWithIdentifier(self.cellReuseIdentifier) as? TimelineCell
        }
        let tweet = item as Tweet
        self._updateCell(offlineCell!, tweet: tweet)

        offlineCell!.updateConstraintsIfNeeded()
        offlineCell!.bounds = CGRect(x: 0, y: 0, width: tableViewController.tableView.bounds.size.width, height: CGRectGetHeight(offlineCell!.bounds))
        offlineCell!.layoutIfNeeded()

        //NSLog("height of text \"%@\" is %.2f cell height %.2f", offlineCell!.tweetText.text, offlineCell!.tweetText.bounds.size.height, offlineCell!.bounds.size.height)

        return offlineCell!.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height + 1
    }

    override func estimatedHeightForItem(item: ModelObject, tableViewController: UITableViewController) -> CGFloat
    {
        return 175.0
    }
}
