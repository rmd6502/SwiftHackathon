//
//  TFNTableViewController.swift
//  MiniPlatform
//
//  Created by Robert Diamond on 6/24/14.
//  Copyright (c) 2014 Robert Diamond. All rights reserved.
//

import Foundation
import UIKit

// TODO: stream, rowadapterfactory, and sectionadapter can be generics,
// when this won't crash the compiler
class TFNTableViewController : UITableViewController {
    var stream : Stream?
    var rowAdapters : Dictionary<String,RowAdapter>?
    var sectionAdapter : SectionAdapter?
    var minID : Int64?
    var maxID : Int64?
    var navigationDelegate : NavigationDelegate?
    
    var sections : Array<Array<ModelObject>>?
    {
    didSet {
        self.tableView.reloadData()
    }
    }

    init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        rowAdapters = self._defaultRowAdapters()
    }

    override func viewDidLoad()
    {
        // TODO: install default row adapters, e.g. String
        super.viewDidLoad()
        self.refreshControl?.addTarget(self, action: "refresh", forControlEvents: .ValueChanged)
    }

    func _defaultRowAdapters() -> Dictionary<String,RowAdapter>
    {
        var newRowAdapters = Dictionary<String,RowAdapter>()
        newRowAdapters[NSString(CString: class_getName(ErrorItem))] = ErrorItemRowAdapter()
        return newRowAdapters
    }

    func refresh(sender: AnyObject)
    {
        self.loadTop()
    }

    override func numberOfSectionsInTableView(tableView: UITableView!) -> Int
    {
        return (sections) ? sections!.count : 0
    }

    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        if sections.getLogicValue() && section < sections!.count {
            return sections![section].count
        } else {
            return 0
        }
    }

    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        var cell : UITableViewCell? = nil;
        if sections?.count > indexPath.section && sections![indexPath.section].count > indexPath.row {
            let item : ModelObject = sections![indexPath.section][indexPath.row]
            let itemClass = NSString(CString: class_getName((item as AnyObject).dynamicType))
            if rowAdapters![itemClass].getLogicValue() {
                cell = rowAdapters![itemClass]!.cellForItem(item,tableViewController: self)
            }
        }

        return cell
    }

    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!)
    {
        if sections?.count > indexPath.section && sections![indexPath.section].count > indexPath.row {
            let item : ModelObject = sections![indexPath.section][indexPath.row]
            let itemClass = NSString(CString: class_getName((item as AnyObject).dynamicType))
            if rowAdapters![itemClass].getLogicValue() {
                // This may call right back into this class - beware confusion
                rowAdapters![itemClass]!.didSelectItem(item, tableViewController: self)
            }
        }
    }

    func update()
    {
        self.sections = self.sectionAdapter?.sectionArray(self.stream?.streamObjects)
    }

    func loadTop()
    {
        self.loadTop() {(results : AnyObject?, error : NSError?) in /* do nothing */}
    }

    func loadTop(completion: CompletionFunction)
    {
        stream?.loadTop() {
            (results : AnyObject?, error : NSError?) in
            if let errorval = error {
                if errorval.code >= 400 && errorval.code <= 499 {
                    self.navigationDelegate?.loginIfNeeded(fromViewController: self)
                }
            } else {
                self.update()
            }
            completion(results: results, error: error)
        }
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.refreshControl?.beginRefreshing()
        self.loadTop() {
            (results : AnyObject?, error : NSError?) in
            if let control = self.refreshControl {
                control.endRefreshing()
            }
        }
    }
}
