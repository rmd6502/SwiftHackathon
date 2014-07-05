// Playground - noun: a place where people can play

import Cocoa
import Foundation

var t : Dictionary<String,AnyObject>?

t = ["a": "B", "c": 1048576]

if let u = t {
    println(u["c"])
}
