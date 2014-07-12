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
    @IBOutlet var widthConstraint: NSLayoutConstraint
    @IBOutlet var heightConstraint: NSLayoutConstraint
    
    @IBOutlet var userAvatar: TFNCachedImageView
    @IBOutlet var userNameLabel: UILabel
    @IBOutlet var userHandleLabel: UILabel
    @IBOutlet var timeLabel: UILabel
    @IBOutlet var replyButton: UIButton
    @IBOutlet var retweetButton: UIButton
    @IBOutlet var favoriteButton: UIButton
    @IBOutlet var followButton: UIButton
    @IBOutlet var tweetText : UITextView
    @IBOutlet var mediaCollection: UICollectionView

//    override func touchesEnded(touches: NSSet!, withEvent event: UIEvent!)
//    {
//        for (let touch) in touches.allObjects {
//            let pt = touch.locationInView(self.tweetText)
//            if let activeMap = activeAreas {
//                for (let (entity,range)) in activeMap {
//                    for (let rect) in self.tweetText.selectionRectsForRange(range as UITextRange) {
//                        if (CGRectContainsPoint(rect.rect, pt)) {
//                            NSLog("touched entity %@", entity)
//                            delegate?.didSelectEntity(entity, cell: self)
//                            return
//                        }
//                    }
//                }
//            }
//        }
//        super.touchesEnded(touches, withEvent: event)
//    }

}
