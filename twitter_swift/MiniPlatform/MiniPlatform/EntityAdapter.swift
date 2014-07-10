//
//  EntityAdapter.swift
//  MiniPlatform
//
//  Created by Robert Diamond on 7/10/14.
//  Copyright (c) 2014 Robert Diamond. All rights reserved.
//

/**
 * Entity adapters are one level below RowAdapters.  They will handle
 * rendering and events on entities within a cell.  Entities can include
 * plain text, links, user mentions, hashtags in tweets, media and images
 * associated with cells, etc.
 * The row adapter will get a standard set of entity adapters, then
 * the RowAdapter then the VC will get to override and supplement them.
 * The Row Adapter will receive the cellForRowAtIndexPath, and if the
 * item has entities it will invoke the appropriate entityAdapters to
 * render them.
 * When a tap occurs in a cell, the rowadapter will get the tap event,
 * and if that touch was within an entity it will invoke the entity's 
 * action there (where it will already have the vc in context).  Else
 * it will return false and eventually get called back in the standard
 * didSelectRowAtIndexPath we know and love.
 */
class EntityAdapter : NSObject {

}
