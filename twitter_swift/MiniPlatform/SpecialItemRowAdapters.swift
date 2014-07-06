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

    override func cellForItem(item: ModelObject, tableView: UITableView) -> UITableViewCell?
    {
        var cell : UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(self.cellReuseIdentifier) as? UITableViewCell

        if !cell.getLogicValue() {
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: self.cellReuseIdentifier)
        }
        if let errorItem = item as? ErrorItem {
            cell!.textLabel.text = errorItem.error?.localizedDescription
            if let code = errorItem.error?.code {
                cell!.detailTextLabel.text = NSString(format: "code %@",code)
            }
        }

        return cell
    }
}