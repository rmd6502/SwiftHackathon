//
//  URLEntityAdapter.swift
//  MiniPlatform
//
//  Created by Robert Diamond on 7/11/14.
//  Copyright (c) 2014 Robert Diamond. All rights reserved.
//

class URLEntityAdapter : NSObject,EntityAdapter {
    var reuseIdentifier : String?
    
    func attributedStringForEntity(entity : Entity, inItem item : ModelObject) -> NSAttributedString?
    {
        var urlDisplayString = ""
        switch entity.entityType {
        case .Url(let displayString, let expandedURL, let url):
            urlDisplayString = displayString
        default:
            return nil
        }
        return NSAttributedString(string: urlDisplayString,attributes: [NSForegroundColorAttributeName: UIColor.blueColor()])
    }

    func collectionViewCellForEntity(entity : Entity, inItem item : ModelObject, collectionView : UICollectionView, indexPath : NSIndexPath) -> UICollectionViewCell?
    {
        // we don't display images for these
        return nil
    }

    func tapActionForEntity(entity : Entity, inItem item : ModelObject) -> EntityCallbackFunction?
    {
        return { (entity, item, controller) in
            var responseURL : NSURL? = nil
            switch entity.entityType {
            case .Url(let displayString, let expandedURL, let url):
                responseURL = expandedURL
            default:
                return false
            }
            controller.navigationController.pushViewController(WebViewController(url: responseURL), animated: true)
            return true
        }
    }
}
