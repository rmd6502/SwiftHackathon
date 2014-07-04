//
//  T1AppNavigationDelegate.swift
//  twitter_swift
//
//  Created by Robert Diamond on 6/16/14.
//  Copyright (c) 2014 Robert Diamond. All rights reserved.
//

import MiniPlatform
import UIKit

class T1AppNavigationDelegate : NSObject, NavigationDelegate, UITabBarControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var navigationController : UINavigationController
    {
        didSet {
            NSLog("navbar set")
            self.tabBarController = navigationController.viewControllers[0] as? UITabBarController
            if (tabBarController?.viewControllers.count > 0) {
                for (var vc : AnyObject) in tabBarController!.viewControllers {
                    if let tvc = vc as? TFNTableViewController {
                        tvc.navigationDelegate = self
                    }
                }
            }
        }
    }
    
    var tabBarController : UITabBarController?

    init()
    {
        NSLog("created a navdelegate")
        super.init()
        (UIApplication.sharedApplication().delegate as AppDelegate).tabBarControllerDelegate = self
    }

    deinit
    {
        NSLog("goodbye cruel world")
    }

    func loginIfNeeded(fromViewController viewController: UIViewController!)
    {
        if TFNTwitter.sharedTwitter.currentAccount == nil {
            dispatch_async(dispatch_get_main_queue()) {
                var storyBoard = UIStoryboard(name: "Main", bundle: nil)
                var loginVC : T1LoginViewController! = storyBoard.instantiateViewControllerWithIdentifier("login") as T1LoginViewController
                viewController?.navigationController?.pushViewController(loginVC, animated: true)
            }
        }
    }
}