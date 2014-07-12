//
//  WebViewController.swift
//  MiniPlatform
//
//  Created by Robert Diamond on 7/12/14.
//  Copyright (c) 2014 Robert Diamond. All rights reserved.
//

class WebViewController : UIViewController, UIWebViewDelegate {
    var currentURL : NSURL?

    override func loadView()
    {
        self.view = UIWebView()
    }

    override func viewDidLoad()
    {
        if currentURL.getLogicValue() {
            (self.view as UIWebView).loadRequest(NSURLRequest(URL: currentURL!))
        }
    }

    init(url : NSURL?)
    {
        currentURL = url
        super.init(nibName: nil, bundle: nil)
    }
}
