//
//  Entity.swift
//  MiniPlatform
//
//  Created by Robert Diamond on 6/21/14.
//  Copyright (c) 2014 Robert Diamond. All rights reserved.
//

import Foundation

enum EntityType {
    case Url(String, NSURL, NSURL), Description(String, NSURL, NSURL)
    case Image(NSURL)
    case Hashtag(String), UserMention(Int64,String,String), StockSymbol(String)
}

enum EntityKeys : String {
    case URLS = "urls"
    case HASHTAGS = "hashtags"
    case MEDIA = "media"
    case USERS = "user_mentions"
    case TICKERS = "symbols"
    case DISPLAY_URL = "display_url"
    case EXPANDED_URL = "expanded_url"
    case URL = "url"
    case USER_ID = "id"
    case INDICES = "indices"
    case USER_NAME = "name"
    case USER_HANDLE = "screen_name"
    case HASHTAG = "text"
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
            case EntityKeys.URLS.toRaw():
                entities.extend(_parseURLS(parent: parentObject,array: v)!)
            case EntityKeys.HASHTAGS.toRaw():
                entities.extend(_parseHashtags(parent: parentObject,array: v)!)
            case EntityKeys.USERS.toRaw():
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
                var displayURL = urlDict[EntityKeys.DISPLAY_URL.toRaw()] as NSString
                var expandedURL = urlDict[EntityKeys.EXPANDED_URL.toRaw()] as NSString
                var url = urlDict[EntityKeys.URL.toRaw()] as NSString

                var newEntity = Entity(parent: parentObject, type: EntityType.Url(displayURL, NSURL(string: expandedURL), NSURL(string: url)))
                newEntity.indices = _parseIndices(urlDict[EntityKeys.INDICES.toRaw()])
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
                var newEntity = Entity(parent: parentObject, type: EntityType.Hashtag(hashDict[EntityKeys.HASHTAG.toRaw()] as NSString))
                newEntity.indices = _parseIndices(hashDict[EntityKeys.INDICES.toRaw()])
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
                var userID = (userDict[EntityKeys.USER_ID.toRaw()] as NSNumber).longLongValue
                var userName = userDict[EntityKeys.USER_NAME.toRaw()] as NSString
                var userHandle = userDict[EntityKeys.USER_HANDLE.toRaw()] as NSString
                var newEntity = Entity(parent: parentObject, type: EntityType.UserMention(userID, userName, userHandle))
                newEntity.indices = _parseIndices(userDict[EntityKeys.INDICES.toRaw()])
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