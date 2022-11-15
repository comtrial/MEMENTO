//extension UIColor {
//import UIKit
//
//extension UIColor {
//    public convenience init?(hex: String) {
//        let r, g, b, a: CGFloat
//
//        if hex.hasPrefix("#") {
//            let start = hex.index(hex.startIndex, offsetBy: 1)
//            let hexColor = String(hex[start...])
//
//            if hexColor.count == 8 {
//                let scanner = Scanner(string: hexColor)
//                var hexNumber: UInt64 = 0
//
//                if scanner.scanHexInt64(&hexNumber) {
//                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
//                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
//                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
//                    a = CGFloat(hexNumber & 0x000000ff) / 255
//
//                    self.init(red: r, green: g, blue: b, alpha: a)
//                    return
//                }
//            }
//        }
//
//        return nil
//    }
//}
import Foundation
import SwiftUI

extension Color {
    static let black100  = Color("Black100")
    static let black60  = Color("Black60")
    static let black38  = Color("Black38")
    static let bgwhite  = Color("White")
    static let lightGrey  = Color("LightGrey")
    static let orange100  = Color("Orange100")
    static let orange38  = Color("Orange38")
    static let blue100  = Color("Blue100")
    static let blue38  = Color("Blue38")


}
