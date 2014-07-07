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
@objc class RowAdapter : NSObject {
    let SECONDS_PER_MINUTE : NSTimeInterval
    let SECONDS_PER_HOUR : NSTimeInterval
    let SECONDS_PER_DAY : NSTimeInterval
    let formatter = NSDateFormatter()

    var cellReuseIdentifier : String!

    func cellForItem(item : ModelObject, tableViewController : UITableViewController) -> UITableViewCell?
    {
        assert(false, "Need to implement cellForItem", file: __FILE__, line: __LINE__)
        // handled in subclass
        return nil
    }

    func didSelectItem(item : ModelObject, tableViewController : UITableViewController)
    {
        // up to subclass
    }

    init(reuseIdentifier : String)
    {
        SECONDS_PER_MINUTE = 60.0
        SECONDS_PER_HOUR = 60.0 * self.SECONDS_PER_MINUTE
        SECONDS_PER_DAY = 24.0 * self.SECONDS_PER_HOUR
        super.init()
        self.cellReuseIdentifier = reuseIdentifier
        formatter.dateStyle = .ShortStyle
        formatter.timeStyle = .NoStyle
    }

    func formatTimeInterval(interval : NSTimeInterval) -> String?
    {
        switch (interval) {
        case SECONDS_PER_DAY..7*SECONDS_PER_DAY:
            return NSString(format: "%.0f day%@", interval/SECONDS_PER_DAY, (interval/SECONDS_PER_DAY >= 1.5) ? "s" : "")
        case SECONDS_PER_HOUR..SECONDS_PER_DAY:
            return NSString(format: "%.0f hour%@", interval/SECONDS_PER_HOUR, (interval/SECONDS_PER_HOUR >= 1.5) ? "s" : "")
        case SECONDS_PER_MINUTE..SECONDS_PER_HOUR:
            return NSString(format: "%.0f minute%@", interval/SECONDS_PER_MINUTE, (interval/SECONDS_PER_MINUTE >= 1.5) ? "s" : "")
        case 1..SECONDS_PER_MINUTE:
            return NSString(format: "%.0f second%@", interval, (interval >= 1.5) ? "s" : "")
        case 0..1:
            return "now"
        default:
            return formatter.stringFromDate(NSDate(timeIntervalSinceNow: -interval))
        }
    }
}
