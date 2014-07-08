//
//  TimelineViewController.swift
//  twitter_swift
//
//  Created by Robert Diamond on 6/6/14.
//  Copyright (c) 2014 Robert Diamond. All rights reserved.
//

import UIKit
import MiniPlatform

class TimelineViewController : TFNTableViewController {
    
    init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        self.navigationItem.title = self.title
        self.stream = HomeTimelineStream()
        self.sectionAdapter = HomeTimelineSectionAdapter()
        var rowAdapters = self.rowAdapters!
        rowAdapters[NSString(CString: class_getName(Tweet), encoding: NSUTF8StringEncoding)] = StatusRowAdapter(reuseIdentifier: "StatusCell")
        self.rowAdapters = rowAdapters
    }

}