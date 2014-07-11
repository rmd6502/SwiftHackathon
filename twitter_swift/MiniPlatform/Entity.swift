//
//  Entity.swift
//  MiniPlatform
//
//  Created by Robert Diamond on 6/21/14.
//  Copyright (c) 2014 Robert Diamond. All rights reserved.
//

import Foundation

enum EntityType {
    case Url(displayString: String, expandedURL: NSURL, url : NSURL), Description(displayString: String, expandedURL: NSURL, url : NSURL)
    case Image(imageURL : NSURL)
    case Hashtag(hashTag : String), UserMention(userID : Int64, userName : String, userHandle : String), StockSymbol(ticker : String)
}

struct EntityKeys {
    static let URLS = "urls"
    static let HASHTAGS = "hashtags"
    static let MEDIA = "media"
    static let USERS = "user_mentions"
    static let TICKERS = "symbols"
    static let DISPLAY_URL = "display_url"
    static let EXPANDED_URL = "expanded_url"
    static let URL = "url"
    static let USER_ID = "id"
    static let INDICES = "indices"
    static let USER_NAME = "name"
    static let USER_HANDLE = "screen_name"
    static let HASHTAG = "text"
}

class Entity : NSObject {
    unowned var parent : ModelObject
    var entityType : EntityType
    var indices : NSRange!

    class func entitiesWithDictionary(parent parentObject : ModelObject,dict : Dictionary<String,Array<AnyObject>>) -> [Entity]?
    {
        var entities = Array<Entity>()
        for (k,v) in dict {
            switch (k) {
            case EntityKeys.URLS:
                entities.extend(_parseURLS(parent: parentObject,array: v)!)
            case EntityKeys.HASHTAGS:
                entities.extend(_parseHashtags(parent: parentObject,array: v)!)
            case EntityKeys.USERS:
                entities.extend(_parseUserMentions(parent: parentObject,array: v)!)
            default:
                break
            }
        }
        return entities
    }

    class func _parseURLS(parent parentObject : ModelObject,array : Array<AnyObject>!) -> [Entity]?
    {
        var entities = [Entity]()
        for (var urlItem : AnyObject) in array {
            if let urlDict = urlItem as? Dictionary<String,AnyObject> {
                var displayURL = urlDict[EntityKeys.DISPLAY_URL] as NSString
                var expandedURL = urlDict[EntityKeys.EXPANDED_URL] as NSString
                var url = urlDict[EntityKeys.URL] as NSString

                var newEntity = Entity(parent: parentObject, type: EntityType.Url(displayString: displayURL, expandedURL: NSURL(string: expandedURL), url: NSURL(string: url)))
                newEntity.indices = _parseIndices(urlDict[EntityKeys.INDICES])
                entities.append(newEntity)
            }
        }
        return entities
    }

    class func _parseIndices(obj : AnyObject?) -> NSRange?
    {
        if let indexArray = obj as? Array<Int> {
            if indexArray.count > 1 {
                return NSMakeRange(indexArray[0], indexArray[1] - indexArray[0])
            }
        }
        return nil
    }

    class func _parseHashtags(parent parentObject : ModelObject,array : Array<AnyObject>!) -> [Entity]?
    {
        var entities = [Entity]()
        for (var hashItem : AnyObject) in array {
            if let hashDict = hashItem as? Dictionary<String,AnyObject> {
                var newEntity = Entity(parent: parentObject, type: EntityType.Hashtag(hashTag: hashDict[EntityKeys.HASHTAG] as NSString))
                newEntity.indices = _parseIndices(hashDict[EntityKeys.INDICES])
                entities.append(newEntity)
            }
        }
        return entities
    }

    class func _parseUserMentions(parent parentObject : ModelObject,array : Array<AnyObject>!) -> [Entity]?
    {
        var entities = [Entity]()
        for (var userItem : AnyObject) in array {
            if let userDict = userItem as? Dictionary<String,AnyObject> {
                var userID = (userDict[EntityKeys.USER_ID] as NSNumber).longLongValue
                var userName = userDict[EntityKeys.USER_NAME] as NSString
                var userHandle = userDict[EntityKeys.USER_HANDLE] as NSString
                var newEntity = Entity(parent: parentObject, type: EntityType.UserMention(userID: userID, userName: userName, userHandle: userHandle))
                newEntity.indices = _parseIndices(userDict[EntityKeys.INDICES])
                entities.append(newEntity)
            }
        }
        return entities
    }

    init(parent parentObject : ModelObject, type : EntityType)
    {
        entityType = type
        parent = parentObject
        super.init()
    }
}