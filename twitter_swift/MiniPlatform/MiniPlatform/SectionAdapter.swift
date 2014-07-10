//
//  SectionAdapter.swift
//  MiniPlatform
//
//  Created by Robert Diamond on 6/24/14.
//  Copyright (c) 2014 Robert Diamond. All rights reserved.
//

import Foundation

class SectionAdapter : NSObject {

    func sectionArray(Array<ModelObject>?) -> Array<Array<ModelObject>>?
    {
        // default implementation does nothing
        return nil
    }

    func tableViewController(tableViewController: UITableViewController!, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 0
    }

    func tableViewController(tableViewController: UITableViewController!, heightForFooterInSection section: Int) -> CGFloat
    {
        return 0
    }

    func tableViewController(tableViewController: UITableViewController!, estimatedHeightForHeaderInSection section: Int) -> CGFloat
    {
        return 0
    }

    func tableViewController(tableViewController: UITableViewController!, estimatedHeightForFooterInSection section: Int) -> CGFloat
    {
        return 0
    }

    func tableViewController(tableViewController: UITableViewController!, viewForHeaderInSection section: Int) -> UIView!
    {
        return nil
    }

    func tableViewController(tableViewController: UITableViewController!, viewForFooterInSection section: Int) -> UIView!
    {
        return nil
    }

}