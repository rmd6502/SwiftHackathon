//
//  UserMentionEntityAdapter.swift
//  MiniPlatform
//
//  Created by Robert Diamond on 7/11/14.
//  Copyright (c) 2014 Robert Diamond. All rights reserved.
//

class UserMentionEntityAdapter : NSObject,EntityAdapter {
    var reuseIdentifier : String?
    
    func attributedStringForEntity(entity : Entity, inItem item : ModelObject) -> NSAttributedString?
    {
        var userDisplayString = ""
        switch entity.entityType {
        case .UserMention(let userID, let userName, let userHandle):
            userDisplayString = "@" + userHandle
        default:
            return nil
        }
        return NSAttributedString(string: userDisplayString,attributes: [NSForegroundColorAttributeName: UIColor.blueColor()])
    }
    
    func collectionViewCellForEntity(entity : Entity, inItem item : ModelObject, collectionView : UICollectionView, indexPath : NSIndexPath) -> UICollectionViewCell?
    {
        // we don't display images for these
        return nil
    }

    func tapActionForEntity(entity : Entity, inItem item : ModelObject) -> EntityCallbackFunction?
    {
        return nil
    }
}

