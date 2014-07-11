//
//  ImageEntityAdapter.swift
//  MiniPlatform
//
//  Created by Robert Diamond on 7/11/14.
//  Copyright (c) 2014 Robert Diamond. All rights reserved.
//

class ImageEntityAdapter : NSObject,EntityAdapter {
    var reuseIdentifier : String? = "ImageCell"

    func attributedStringForEntity(entity : Entity, inItem item : ModelObject) -> NSAttributedString?
    {
        // we don't display anything in the text box for these
        return nil
    }

    func collectionViewCellForEntity(entity : Entity, inItem item : ModelObject, collectionView : UICollectionView) -> UICollectionViewCell?
    {
        return nil
    }

    func tapActionForEntity(entity : Entity, inItem item : ModelObject) -> EntityCallbackFunction?
    {
        return nil        
    }
}

