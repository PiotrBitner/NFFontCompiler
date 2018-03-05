//
//  NFColor.swift
//  NFLabel
//
//  Created by Piotr Bitner on 08/02/2018.
//

import Foundation

class  NFColor {
    
    
    static func mixColors(firstColor: UIColor, secondColor: UIColor, mixValue: CGFloat, alpha: CGFloat, mixAlpha: Bool = true) -> UIColor {
        
        var r0: CGFloat = 0, g0: CGFloat = 0, b0: CGFloat = 0, a0: CGFloat = 0
        firstColor.getRed(&r0, green: &g0, blue: &b0, alpha: &a0)
        
        var r1: CGFloat = 0, g1: CGFloat = 0, b1: CGFloat = 0, a1: CGFloat = 0
        secondColor.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        
        // first - (first - second) * t
        let r = r0 - (r0 - r1 ) * mixValue
        let g = g0 - (g0 - g1 ) * mixValue
        let b = b0 - (b0 - b1 ) * mixValue
        
        let a:CGFloat
        
        if mixAlpha {
            a = a0 - (a0 - a1 ) * mixValue
        } else {
            a = 1.0
        }
        
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
    
    static func colorToJSON(color: UIColor) -> NFJSON {
        
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        color.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        // check Appe codying
        return  ["r" : r as AnyObject , "g": g as AnyObject, "b": b as AnyObject, "a" :a as AnyObject]
    }
    
    static func colorFromJSON(json: NFJSON ) ->UIColor {
        
        let r: CGFloat = json["r"] as? CGFloat ?? 0
        let g: CGFloat = json["g"] as? CGFloat ?? 0
        let b: CGFloat = json["b"] as? CGFloat ?? 0
        let a: CGFloat = json["a"] as? CGFloat ?? 1
        
        return  UIColor(red: r, green: g, blue: b, alpha: a)
    }
    
}
