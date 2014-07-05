//
//  HomeTimelineStream.swift
//  MiniPlatform
//
//  Created by Robert Diamond on 6/22/14.
//  Copyright (c) 2014 Robert Diamond. All rights reserved.
//

import Foundation

class HomeTimelineStream : Stream {

    override func load(#minID : Int64?, maxID : Int64?, completion : CompletionFunction)
    {
        var params = Dictionary<String,String>()
        if minID.getLogicValue() {
            params["since_id"] = String(minID!)
        }
        if maxID.getLogicValue() {
            params["max_id"] = String(maxID!)
        }
        TFNTwitter.sharedTwitter.twitterAPI.twitterGetRequestWithResponse(.GetHomeTimeline, parameters: params) { (response, data, error) in
            var myError : NSError? = error
            NSLog("got a reply!")
            if let myData = data {
                NSLog("%@\nData %@", response!, NSString(data: myData, encoding: NSUTF8StringEncoding))
            }
            if (response?.statusCode >= 400 && response?.statusCode <= 499) {
                TFNTwitter.sharedTwitter.currentAccount = nil
                if !error.getLogicValue() {
                    myError = NSError(domain: self.STREAM_ERROR_DOMAIN, code: response!.statusCode, userInfo: [NSLocalizedDescriptionKey: "Credentials invalid"])
                }
            }
            if myError.getLogicValue() {
                completion(results: nil, error: myError)
            } else {
                var options = NSJSONReadingOptions(0)
                var results : Array<Tweet>? = nil
                if let resultData = data {
                    var jsonData : AnyObject! = NSJSONSerialization.JSONObjectWithData(resultData, options: options, error: &myError)
                    results = self._parseJSONData(jsonData)
                }
                completion(results: results, error: myError)
            }
        }
    }
    
    func _parseJSONData(data: AnyObject!) -> Array<Tweet>?
    {
        var results : Array<Tweet>? = nil
        if let jsonArray = data as? Array<Dictionary<String,AnyObject>> {
            for (var tweetDict) in jsonArray {
                var tweet = Tweet(dict: tweetDict)
            }
        }
        
        return results
    }
}