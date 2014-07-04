//
//  User.swift
//  MiniPlatform
//
//  Created by Robert Diamond on 6/21/14.
//  Copyright (c) 2014 Robert Diamond. All rights reserved.
//

import Foundation

class User : ModelObject {
    let CONTRIBUTORS_ENABLED_KEY = "contributors_enabled"
    let CREATED_AT_KEY = "created_at"
    let DESCRIPTION_KEY = "description"
    let PROFILE_IMAGE_URL_KEY = "profile_image_url"
    let PROFILE_IMAGE_URL_HTTPS_KEY = "profile_image_url_https"
    let ENTITIES_KEY = "entities"
    let FAVORITES_KEY = "favourites_count"
    let FOLLOW_REQUESTED_KEY = "follow_request_sent"
    let FOLLOWERS_KEY = "followers_count"
    let FOLLOWING_KEY = "following"
    let FRIENDS_COUNT_KEY = "friends_count"
    let GEO_ENABLED_KEY = "geo_enabled"
    let ID_KEY = "id"
    let TRANSLATION_ENABLED_KEY = "is_translation_enabled"
    let TRANSLATOR_KEY = "is_translator"
    let LOCALE_KEY = "lang"
    let LISTED_COUNT_KEY = "listed_count"
    let LOCATION_KEY = "location"
    let NAME_KEY = "name"
    let NOTIFICATIONS_ENABLED_KEY = "notifications"
    let PROFILE_BACKGROUND_COLOR_KEY = "profile_background_color"
    let PROFILE_BACKGROUND_IMAGE_URL_KEY = "profile_background_image_url"
    let PROFILE_BACKGROUND_IMAGE_URL_HTTPS_KEY = "profile_background_image_url_https"
    let PROFILE_IMAGE_BACKGROUND_TILE_KEY = "profile_background_tile"
    let PROFILE_LINK_COLOR_LEY = "profile_link_color"
    let PROFILE_LINK_BORDER_COLOR_KEY = "profile_link_border_color"
    let PROFILE_SIDEBAR_FILL_COLOR_KEY = "profile_sidebar_fill_color"
    let PROFILE_TEXT_COLOR_KEY = "profile_text_color"
    let PROFILE_USE_BACKGROUND_IMAGE_KEY = "profile_use_background_image"
    let PROTECTED_KEY = "protected"
    let SCREEN_NAME_KEY = "screen_name"
    let STATUS_COUNT_KEY = "statuses_count"
    let TIME_ZONE_KEY = "time_zone"
    let URL_KEY = "url"
    let UTC_OFFSET_KEY = "utc_offset"
    let VERIFIED_KEY = "verified"
    
    var contributorsEnabled : Bool = false
    var createdAt : NSDate?
    var userDescription : String!
    var entities : Array<Entity>?
    var favorites : Int = 0
    var followers : Int = 0
    var following : Int = 0
    var followRequestSentByUser : Bool = false
    var followedByUser : Bool = false
    var friends : Int = 0
    var geoEnabled : Bool = false
    var userID : Int64 = 0
    var locale : String!
    var listedCount : Int = 0
    var location : Place?
    var name : String!
    var notificationsToUser : Bool = false
    var profileImageURL : NSURL?
    var profileBackgroundColor : UIColor?
    var profileBackgroundImage : NSURL?
    var tileBackgroundImage : Bool = false
    var profileLinkColor : UIColor?
    var profileSidebarFillColor : UIColor?
    var profileTextColor : UIColor?
    var profileUseBackgroundImage : Bool = false
    var protected : Bool = false
    var screenName : String!
    var statusCount : Int = 0
    var timeZone : String!
    var url : NSURL?
    var utcOffset : Int = 0
    var verified : Bool = false
    
    convenience init(dict : Dictionary<String,String>?)
    {
        self.init()
    }
}