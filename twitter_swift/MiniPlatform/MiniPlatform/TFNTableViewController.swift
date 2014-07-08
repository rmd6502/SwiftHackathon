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
        dispatch_async(dispatch_get_main_queue()) {
            self.tableView.reloadData()
        }
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
        self.refreshControl?.addTarget(self, action: "refresh:", forControlEvents: .ValueChanged)
    }

    func _defaultRowAdapters() -> Dictionary<String,RowAdapter>
    {
        var newRowAdapters = Dictionary<String,RowAdapter>()
        newRowAdapters[NSString(CString: class_getName(ErrorItem),encoding: NSUTF8StringEncoding)] = ErrorItemRowAdapter()
        newRowAdapters[NSString(CString: class_getName(FooterItem),encoding: NSUTF8StringEncoding)] = FooterItemRowAdapter()
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
            let itemClass = NSString(CString: class_getName((item as AnyObject).dynamicType),encoding: NSUTF8StringEncoding)
            if rowAdapters![itemClass].getLogicValue() {
                cell = rowAdapters?[itemClass]?.cellForItem(item,tableViewController: self)
            }
        }

        return cell
    }

    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!)
    {
        if sections?.count > indexPath.section && sections![indexPath.section].count > indexPath.row {
            let item : ModelObject = sections![indexPath.section][indexPath.row]
            let itemClass = NSString(CString: class_getName((item as AnyObject).dynamicType),encoding: NSUTF8StringEncoding)
            if let tIndexPath = indexPath {
                if rowAdapters![itemClass].getLogicValue() {
                    // This may call right back into this class - beware confusion
                    rowAdapters?[itemClass]?.didSelectItem(item, tableViewController: self, indexPath: tIndexPath)
                }
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
            self.refreshControl?.endRefreshing()
            if let errorval = error {
                if errorval.code == 403 || errorval.code == 401 {
                    TFNTwitter.sharedTwitter.currentAccount = nil
                    self.navigationDelegate?.loginIfNeeded(fromViewController: self)
                } else {
                    let e = ErrorItem()
                    e.error = errorval
                    self.sections = [[e]]
                }
            } else {
                self.update()
            }
            completion(results: results, error: error)
        }
    }

    func loadBottom(indexPath : NSIndexPath?)
    {
        stream?.loadBottom() {
            (results : AnyObject?, error : NSError?) in
            self.refreshControl?.endRefreshing()
            if let errorval = error {
                if errorval.code == 403 {
                    TFNTwitter.sharedTwitter.currentAccount = nil
                    self.navigationDelegate?.loginIfNeeded(fromViewController: self)
                }
            } else {
                self.update()
            }
        }
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.refreshControl?.beginRefreshing()
        self.loadTop()
    }
}
