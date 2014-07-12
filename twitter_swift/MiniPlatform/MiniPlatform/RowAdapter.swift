//
//  RowAdapter.swift
//  MiniPlatform
//
//  Created by Robert Diamond on 6/26/14.
//  Copyright (c) 2014 Robert Diamond. All rights reserved.
//

import Foundation
import UIKit

/**
 * Pluggables to handle cells in multiple view controllers
 */
@objc class RowAdapter : NSObject,UICollectionViewDataSource {
    let SECONDS_PER_MINUTE : NSTimeInterval
    let SECONDS_PER_HOUR : NSTimeInterval
    let SECONDS_PER_DAY : NSTimeInterval
    let formatter = NSDateFormatter()

    var cellReuseIdentifier : String!

    var entityAdapters : [String:EntityAdapter]

    func heightForItem(item : ModelObject, tableViewController : UITableViewController) -> CGFloat
    {
        // subclasses must implement
        return 0;
    }

    func estimatedHeightForItem(item : ModelObject, tableViewController : UITableViewController) -> CGFloat
    {
        // subclasses must implement
        return 80;
    }

    /**
     * Returns the UITableViewCell that corresponds to the ModelObject
     */
    func cellForItem(item : ModelObject, tableViewController : UITableViewController) -> UITableViewCell?
    {
        assert(false, "Need to implement cellForItem", file: __FILE__, line: __LINE__)
        // handled in subclass
        return nil
    }

    func didSelectItem(item : ModelObject, tableViewController : UITableViewController, indexPath : NSIndexPath?)
    {
        // up to subclass
    }

    init(reuseIdentifier : String)
    {
        SECONDS_PER_MINUTE = 60.0
        SECONDS_PER_HOUR = 60.0 * self.SECONDS_PER_MINUTE
        SECONDS_PER_DAY = 24.0 * self.SECONDS_PER_HOUR

        entityAdapters = [:]
        super.init()
        entityAdapters = [EntityKeys.URLS : URLEntityAdapter(), EntityKeys.USERS : UserMentionEntityAdapter(), EntityKeys.HASHTAGS : HashtagEntityAdapter(), EntityKeys.TICKERS : CashtagEntityAdapter(), EntityKeys.IMAGES : ImageEntityAdapter()]
        self.cellReuseIdentifier = reuseIdentifier
        formatter.dateStyle = .ShortStyle
        formatter.timeStyle = .NoStyle
    }

    func _nameForClass(classObject : AnyClass) -> NSString
    {
        return NSString(CString: class_getName(classObject), encoding: NSUTF8StringEncoding)
    }

    func formatTimeInterval(interval : NSTimeInterval) -> String?
    {
        switch (interval) {
        case SECONDS_PER_DAY..<7*SECONDS_PER_DAY:
            return NSString(format: "%.0f day%@", interval/SECONDS_PER_DAY, (interval/SECONDS_PER_DAY >= 1.5) ? "s" : "")
        case SECONDS_PER_HOUR..<SECONDS_PER_DAY:
            return NSString(format: "%.0f hour%@", interval/SECONDS_PER_HOUR, (interval/SECONDS_PER_HOUR >= 1.5) ? "s" : "")
        case SECONDS_PER_MINUTE..<SECONDS_PER_HOUR:
            return NSString(format: "%.0f minute%@", interval/SECONDS_PER_MINUTE, (interval/SECONDS_PER_MINUTE >= 1.5) ? "s" : "")
        case 1..<SECONDS_PER_MINUTE:
            return NSString(format: "%.0f second%@", interval, (interval >= 1.5) ? "s" : "")
        case 0..<1:
            return "now"
        default:
            return formatter.stringFromDate(NSDate(timeIntervalSinceNow: -interval))
        }
    }

    /**
     * Determines if a tap was in an entity, and handles the tap if the entity defines an action.
     * Returns true if the tap was handled
     */
    func didTapRow(point : CGPoint, item : ModelObject, tableViewController : UITableViewController) -> Bool
    {
        return false
    }

    func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int
    {
        return 0;
    }

    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell!
    {
        return nil;
    }

}
