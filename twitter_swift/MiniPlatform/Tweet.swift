//
//  Tweet.swift
//  MiniPlatform
//
//  Created by Robert Diamond on 6/21/14.
//  Copyright (c) 2014 Robert Diamond. All rights reserved.
//

import Foundation

class Tweet : NSObject,Identifiable {
    let CONTRIBUTORS_KEY = "contributors"
    let COORDINATES_KEY = "coordinates"
    let CREATED_AT_KEY = "created_at"
    let ENTITIES_KEY = "entities"
    let FAVORITE_COUNT_KEY = "favorite_count"
    let ID_KEY = "id"
    let IN_REPLY_TO_STATUS_KEY = "in_reply_to_status_id"
    let IN_REPLY_TO_USER_KEY = "in_reply_to_user_id"


    var ID : Int64 = 0
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
}