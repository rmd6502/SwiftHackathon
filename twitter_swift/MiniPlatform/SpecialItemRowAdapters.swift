//
//  SpecialItemRowAdapters.swift
//  MiniPlatform
//
//  Created by Robert Diamond on 7/6/14.
//  Copyright (c) 2014 Robert Diamond. All rights reserved.
//

class ErrorItemRowAdapter : RowAdapter {
    init()
    {
        super.init(reuseIdentifier: "ErrorItem")
    }

    override func cellForItem(item: ModelObject, tableViewController: UITableViewController) -> UITableViewCell?
    {
        var cell : UITableViewCell? = tableViewController.tableView.dequeueReusableCellWithIdentifier(self.cellReuseIdentifier) as? UITableViewCell

        if !cell.getLogicValue() {
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: self.cellReuseIdentifier)
        }
        if let errorItem = item as? ErrorItem {
            cell!.textLabel.text = errorItem.error?.localizedDescription
            cell!.detailTextLabel.text = "Tap to retry"
        }

        return cell
    }

    override func didSelectItem(item: ModelObject, tableViewController: UITableViewController, indexPath : NSIndexPath?)
    {
        (tableViewController as? TFNTableViewController)?.loadTop()
    }

    override func heightForItem(item: ModelObject, tableViewController: UITableViewController) -> CGFloat
    {
        return 80
    }
}

class FooterItemRowAdapter : RowAdapter {
    init()
    {
        super.init(reuseIdentifier: "ErrorItem")
    }

    override func cellForItem(item: ModelObject, tableViewController: UITableViewController) -> UITableViewCell?
    {
        var cell : UITableViewCell? = tableViewController.tableView.dequeueReusableCellWithIdentifier(self.cellReuseIdentifier) as? UITableViewCell

        if !cell.getLogicValue() {
            cell = UITableViewCell(style: .Default, reuseIdentifier: self.cellReuseIdentifier)
        }
        cell!.textLabel.text = "Tap to load more"

        return cell
    }

    override func didSelectItem(item: ModelObject, tableViewController: UITableViewController, indexPath : NSIndexPath?)
    {
        (tableViewController as? TFNTableViewController)?.loadBottom(indexPath)
    }

    override func heightForItem(item: ModelObject, tableViewController: UITableViewController) -> CGFloat
    {
        return 50
    }
}