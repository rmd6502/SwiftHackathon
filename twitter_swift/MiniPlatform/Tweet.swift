//
//  Tweet.swift
//  MiniPlatform
//
//  Created by Robert Diamond on 6/21/14.
//  Copyright (c) 2014 Robert Diamond. All rights reserved.
//

import Foundation

class Tweet : ModelObject {
    let CONTRIBUTORS_KEY = "contributors"
    let COORDINATES_KEY = "coordinates"
    let CREATED_AT_KEY = "created_at"
    let ENTITIES_KEY = "entities"
    let EXTENDED_ENTITIES_KEY = "extended_entities"
    let FAVORITE_COUNT_KEY = "favorite_count"
    let ID_KEY = "id"
    let IN_REPLY_TO_STATUS_KEY = "in_reply_to_status_id"
    let IN_REPLY_TO_USER_KEY = "in_reply_to_user_id"
    let LOCALE_KEY = "lang"
    let MEDIA_KEY = "media"
    let PLACE_KEY = "place"
    let RETWEET_COUNT_KEY = "retweet_count"
    let RETWEETED_KEY = "retweeted"
    let RETWEETED_STATUS_KEY = "retweeted_status"
    let SOURCE_KEY = "source"
    let TRUNCATED = "truncated"
    let USER_KEY = "user"
    let TEXT_KEY = "text"
    let POSSIBLY_SENSITIVE_KEY = "possibly_sensitive"

    var tweetID : Int64 = 0
    var createdAt : NSDate = NSDate.distantPast() as NSDate
    var contributors : Array<User>?
    var place : Place?
    var entities : Array<Entity>?
    var favorites : Int = 0
    var inReplyToUser : User?
    var locale : String?
    var possiblySensitive : Bool = false
    var retweets : Int = 0
    var tweetSource : String?
    var truncated : Bool = false
    var user : User?
    var text : String?
    // TODO: replace with Tweet? when that won't crash the compiler
    var inReplyToStatus : AnyObject?
    var retweetedStatus : AnyObject?
    
    convenience init(dict: Dictionary<String,AnyObject>?)
    {
        self.init()
        if let jsonDict = dict {
            tweetID = self.parseInt(jsonDict[ID_KEY])
            self.ID = tweetID
            createdAt = self.parseDate(jsonDict[CREATED_AT_KEY])
            if let mytext : AnyObject = jsonDict[TEXT_KEY] {
                text = mytext as? String
            }
            if let userDict : AnyObject = jsonDict[USER_KEY] {
                user = User(dict: userDict as? Dictionary<String,AnyObject>)
            }
            if let entityDict : AnyObject = jsonDict[ENTITIES_KEY] {
                entities = Entity.entitiesWithDictionary(parent: self, dict: entityDict as Dictionary<String,Array<AnyObject>>)
            }
        }
    }
}