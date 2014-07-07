//
//  TFNCachedImage.swift
//  MiniPlatform
//
//  Created by Robert Diamond on 7/5/14.
//  Copyright (c) 2014 Robert Diamond. All rights reserved.
//

struct TFNImageCache {
    static var dictionary = Dictionary<String,NSData>()
}

class TFNCachedImageView : UIImageView {
    var url : NSURL?
    {
    didSet {
        self.updateURL()
    }
    }

    init(coder aDecoder: NSCoder!)
    {
        super.init(coder: aDecoder)
        url = nil
    }

    init(url newurl: NSURL?)
    {
        super.init(image: nil)
        url = newurl
    }

    func updateURL()
    {
        if self.url.getLogicValue() {
            if let data = TFNImageCache.dictionary[self.url!.absoluteString] {
                self.image = UIImage(data: data)
            } else {
                let req = NSURLRequest(URL: url)
                TFNTwitter.sharedTwitter.twitterAPI.requestWithResponse(req) {
                    (response, data, error) in
                    if error == nil && response?.statusCode == 200 && data.getLogicValue() {
                        TFNImageCache.dictionary[self.url!.absoluteString] = data!
                        dispatch_async(dispatch_get_main_queue()) {
                            self.image = UIImage(data: data!)
                        }
                    }
                }
            }
        }
    }
}