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

typealias EntityCallbackFunction = (entity : Entity, item : ModelObject, tableViewController : UITableViewController) -> Bool

protocol EntityAdapter {
    /**
     * If this adapter returns collectionViewCells, this needs to be set
     */
    var reuseIdentifier : String? { get set }

    /**
    * Renders the entity's string.  May return nil.
    */
    func attributedStringForEntity(entity : Entity, inItem item : ModelObject) -> NSAttributedString?

    /**
    * Returns a collectionViewCell for an entity.  May return nil.
    * It is up to the caller to ensure that the numberOfCellsInSection returns the correct number.
    */
    func collectionViewCellForEntity(entity : Entity, inItem item : ModelObject, collectionView : UICollectionView) -> UICollectionViewCell?

    /**
     * Returns an action to perform when the entity is tapped.  May return nil if no action
     * is needed.  TODO: expand to more event types.  The action returns true on successfully
     * handling the event.
     */
    func tapActionForEntity(entity : Entity, inItem item : ModelObject) -> EntityCallbackFunction?
}
