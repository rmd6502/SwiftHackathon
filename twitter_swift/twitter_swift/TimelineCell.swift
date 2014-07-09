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

    var activeAreas : [Entity:AnyObject]?

    override func touchesEnded(touches: NSSet!, withEvent event: UIEvent!)
    {
        var touchedEntity : Entity? = nil
        for (let touch) in touches.allObjects {
            let pt = touch.locationInView(self.tweetText)
            if let activeMap = activeAreas {
                for (let (entity,range)) in activeMap {
                    for (let rect) in self.tweetText.selectionRectsForRange(range as UITextRange) {
                        if (CGRectContainsPoint(rect.rect, pt)) {
                            touchedEntity = entity
                            NSLog("touched entity %@", touchedEntity!)
                        }
                    }
                }
            }
        }
        if !touchedEntity.getLogicValue() {
            super.touchesEnded(touches, withEvent: event)
        }
    }
}
