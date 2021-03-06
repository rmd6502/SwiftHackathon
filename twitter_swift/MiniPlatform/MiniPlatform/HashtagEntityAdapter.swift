//
//  HashtagEntityAdapter.swift
//  MiniPlatform
//
//  Created by Robert Diamond on 7/11/14.
//  Copyright (c) 2014 Robert Diamond. All rights reserved.
//

class HashtagEntityAdapter : NSObject,EntityAdapter {
    var reuseIdentifier : String?
    
    func attributedStringForEntity(entity : Entity, inItem item : ModelObject) -> NSAttributedString?
    {
        var hashDisplayString = ""
        switch entity.entityType {
        case .Hashtag(let hashTag):
            hashDisplayString = "#" + hashTag
        default:
            return nil
        }
        return NSAttributedString(string: hashDisplayString,attributes: [NSForegroundColorAttributeName: UIColor.blueColor()])
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
