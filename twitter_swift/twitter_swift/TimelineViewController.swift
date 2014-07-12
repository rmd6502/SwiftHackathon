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
        // TODO: Ultimately I don't want to even create this file - I want all the dependencies to be
        // resolved via generics
        super.init(coder: aDecoder)
        self.stream = HomeTimelineStream()
        self.sectionAdapter = HomeTimelineSectionAdapter()
        var rowAdapters = self.rowAdapters!
        rowAdapters[NSString(CString: class_getName(Tweet), encoding: NSUTF8StringEncoding)] = StatusRowAdapter(reuseIdentifier: "StatusCell", tableViewController:self)
        self.rowAdapters = rowAdapters
    }
}