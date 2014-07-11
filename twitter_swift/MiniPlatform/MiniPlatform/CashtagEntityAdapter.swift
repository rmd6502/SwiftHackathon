//
//  CashtagEntityAdapter.swift
//  MiniPlatform
//
//  Created by Robert Diamond on 7/11/14.
//  Copyright (c) 2014 Robert Diamond. All rights reserved.
//

class CashtagEntityAdapter : NSObject,EntityAdapter {
    var reuseIdentifier : String?
    
    func attributedStringForEntity(entity : Entity, inItem item : ModelObject) -> NSAttributedString?
    {
        var cashDisplayString = ""
        switch entity.entityType {
        case .StockSymbol(let ticker):
            cashDisplayString = "$" + ticker
        default:
            return nil
        }
        return NSAttributedString(string: cashDisplayString,attributes: [NSForegroundColorAttributeName: UIColor.greenColor()])
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
