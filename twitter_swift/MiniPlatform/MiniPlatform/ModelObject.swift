//
//  ModelObject.swift
//  MiniPlatform
//
//  Created by Robert Diamond on 6/23/14.
//  Copyright (c) 2014 Robert Diamond. All rights reserved.
//

import Foundation

/**
 * anything with an ID field
 */
class ModelObject : NSObject {
    var ID : Int64 = 0
    
    convenience init(dict : Dictionary<String,String>?)
    {
        self.init()
    }
    
    init()
    {
        super.init()
    }
}