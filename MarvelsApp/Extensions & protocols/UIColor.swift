//
//  UIColor.swift
//  MarvelsApp
//
//  Created by aliunco on 3/13/19.
//  Copyright © 2019 Zibazi. All rights reserved.
//

import UIKit

extension UIColor {
    static func fromHexString (hex:String) -> UIColor? {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        if ((cString.count) != 6) {
            return nil
        }
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    static func rgba(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> UIColor {
        return UIColor.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
    
    
    //color pallate
    static var primary1: UIColor { return UIColor.rgba(r: 229, g: 41, b: 59, a: 1) }
}
