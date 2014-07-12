// Playground - noun: a place where people can play

import Cocoa
import Foundation

enum Barcode {
    case UPCA(Int, Int, Int, Int)
    case QRCode(qr: String)
}

var b = Barcode.QRCode(qr: "hello")

switch b {
case .QRCode(let qr):
    println(qr)
default:
    println("other")
    break
}

