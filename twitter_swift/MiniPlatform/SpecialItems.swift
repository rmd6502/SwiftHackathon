//
//  SpecialItems.swift
//  MiniPlatform
//
//  Created by Robert Diamond on 6/30/14.
//  Copyright (c) 2014 Robert Diamond. All rights reserved.
//

class SpecialItem : ModelObject {
    init()
    {
        super.init()
        ID = -1
    }
}

class ErrorItem : SpecialItem {
    var error : NSError?
    init()
    {
        super.init()
        self.ID = -5
    }
}

class EmptyStreamItem : SpecialItem {
    init()
    {
        super.init()
        self.ID = -6
    }
}

class PTRItem : SpecialItem {
    init()
    {
        super.init()
        self.ID = -2
    }
}

class FooterItem : SpecialItem {
    init()
    {
        super.init()
        self.ID = -3
    }
}

class GapItem : SpecialItem {
    init()
    {
        super.init()
        self.ID = -4
    }
}