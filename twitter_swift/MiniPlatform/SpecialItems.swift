//
//  SpecialItems.swift
//  MiniPlatform
//
//  Created by Robert Diamond on 6/30/14.
//  Copyright (c) 2014 Robert Diamond. All rights reserved.
//

class SpecialItem : NSObject,Identifiable {
    var ID : Int64 = -1
}

class ErrorItem : SpecialItem {
    var error : NSError?
    override init()
    {
        super.init()
        self.ID = -5
    }
}

class PTRItem : SpecialItem {
    override init()
    {
        super.init()
        self.ID = -2
    }
}

class FooterItem : SpecialItem {
    override init()
    {
        super.init()
        self.ID = -3
    }
}

class GapItem : SpecialItem {
    override init()
    {
        super.init()
        self.ID = -4
    }
}