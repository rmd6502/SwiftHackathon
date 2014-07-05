//
//  ModelObject.swift
//  MiniPlatform
//
//  Created by Robert Diamond on 6/23/14.
//  Copyright (c) 2014 Robert Diamond. All rights reserved.
//

import Foundation

/**
 * anything with an ID field
 */
class ModelObject : NSObject {
    var ID : Int64 = 0
    
    convenience init(dict : Dictionary<String,AnyObject>?)
    {
        self.init()
    }
    
    init()
    {
        super.init()
    }
    
    func parseInt(obj : AnyObject?) -> Int64
    {
        let ret = (obj as? NSNumber)?.longLongValue
        return (ret) ? ret! : 0
    }
    
    func parseDate(obj : AnyObject?) -> NSDate
    {
        let formatter = NSDateFormatter()
        var ret : NSDate?
        if let value = obj as? String {
            formatter.dateFormat = "EEE MMM dd HH:mm:ss xxxx yyyy"
            ret = formatter.dateFromString(value)
            NSLog("Parsing %@ to %@", value, ret!)
        }
        return (ret) ? ret! : (NSDate.distantPast() as NSDate)
    }
}