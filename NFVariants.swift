//
//  NFVariants.swift
//  NFSign
//
//  Created by Piotr Bitner on 20/02/2018.
//

import Foundation

public enum NFState {
    case normal, bold, light, strong
}

public enum NFScribingSpeed {
    case fast, normal, low
    
    var speed: Int {
        switch self {
        case .fast:
            return 5
        case .normal:
            return 2
        case .low:
            return 1
        }
    }
}

public enum NFQuality {
    case extra, high, normal
    
    var quality: Double {
        switch self {
        case .normal:
            return 2.0
        case .high:
            return 1.0
        case .extra:
            return 0.5
        }
    }
    
    var codeLetter: String {
        switch self {
        case .normal:
            return "N"
        case .high:
            return "H"
        case .extra:
            return "E"
        }
    }
    
}

public enum NFStandardTip: Int {
    case circle, square, triangle
    
    var type: NibType {
        switch self {
        case .circle:
            return .circle
        case .square:
            return .rect
        case .triangle:
            return .triangle
        }
    }
    
    var codeLetter: String {
        switch self {
        case .circle:
            return "C"
        case .square:
            return "R"
        case .triangle:
            return "T"
        }
    }
    
    static func fromInt(int: Int) -> NFStandardTip {
        if int == 0 {
            return .circle
        } else if int == 1 {
            return .square
        } else {
            return .triangle
        }
    }
}



// remove font from variants!
public class NFVariants {
    

    public init() {}

    
    public var underline: Bool = false
    public var italic: Bool = false
    public var quality: NFQuality = .high
    public var state: NFState = .normal
    public var scribingSpeed: NFScribingSpeed = .normal
    public var dim: Bool = false
    public var dimValue: Double = 0.3
    public var standardTip: NFStandardTip = .square
    public var useHardRandom: Bool = false
    public var useLightRandom: Bool = false
    public var color:UIColor = UIColor.black
    public var fontSize: Double = 40.0
    
    public var strongTipScale: CGFloat = 1.0
    public var boldTipScale: CGFloat = 1.0
    public var lightTipScale: CGFloat = 1.0
    
    var lightScale: CGFloat = 1.0
    var strongScale: CGFloat = 1.0
    
    
    var tipScale: CGFloat {
        switch self.state {
        case .normal:
            return 1.0
        case .bold:
            return boldTipScale
        case .light:
            return lightTipScale
        case .strong:
            return strongTipScale
        }
    }
    
    var scale: CGFloat {
        switch self.state {
        case .normal:
            return 1.0
        case .bold:
            return 1.0
        case .light:
            return lightScale
        case .strong:
            return strongScale
        }
    }
    
    var italicAngle: CGFloat = 0.0

    var hardRandom: Double = 0.0
    var lightRandom: Double = 0.0
    
    
    public func applyFont(font: NFFont) {
        
        strongTipScale = font.strongTipScale
        boldTipScale = font.boldTipScale
        lightTipScale = font.lightTipScale
        
        lightScale = font.lightScale
        strongScale = font.strongScale
        
        italicAngle = font.italicAngle
        
        hardRandom = font.hardRandom
        lightRandom = font.lightRandom
    }

}
