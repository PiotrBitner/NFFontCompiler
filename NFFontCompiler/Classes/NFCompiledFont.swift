//
//  NFCompiledFont.swift
//  NFSign
//
//  Created by Piotr Bitner on 26/02/2018.
//

import Foundation

public typealias NFCompiledLines =  [UInt16 : NFVerticalLayer]
public typealias NFCompliedElement = [UInt16 : NFElementsWithWidth]


public class NFCompiledFont: NSObject, NSCoding {
    
    public override init() {}
    
    public init(overview: NFFontOverview, nibs:[NFStandardTip : NFSimpleNib], lines: NFCompiledLines, glyphs: NFCompliedElement, signs: NFCompliedElement) {
      
        self.overview = overview
        self.nibs = nibs
        self.lines = lines
        self.glyphs = glyphs
        self.signs = signs
    }
    
    enum CodingKeys: String, CodingKey {
        case overview
        case nibs
        case lines
        case glyphs
        case signs
    }
    
    public var overview: NFFontOverview?
    public var lines: NFCompiledLines?
    public var glyphs: NFCompliedElement?
    public var signs: NFCompliedElement?
    public var nibs: [NFStandardTip : NFSimpleNib]?
    
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(overview, forKey: CodingKeys.overview.rawValue)
        aCoder.encode(lines, forKey: CodingKeys.lines.rawValue)
        aCoder.encode(glyphs, forKey: CodingKeys.glyphs.rawValue)
        aCoder.encode(signs, forKey: CodingKeys.signs.rawValue)
        
        var nibsI:[Int: NFSimpleNib] = [:]
        if nibs != nil {
            for (key, value) in nibs! {  nibsI[key.rawValue] = value }
        }
        aCoder.encode(nibsI, forKey: CodingKeys.nibs.rawValue)

    }
    
    public convenience required init?(coder aDecoder: NSCoder) {
        let overview = aDecoder.decodeObject(forKey: CodingKeys.overview.rawValue) as! NFFontOverview
        let lines = aDecoder.decodeObject(forKey: CodingKeys.lines.rawValue) as! NFCompiledLines
        let glyphs = aDecoder.decodeObject(forKey: CodingKeys.glyphs.rawValue) as! NFCompliedElement
        let signs = aDecoder.decodeObject(forKey: CodingKeys.signs.rawValue) as! NFCompliedElement
        let nibsI = aDecoder.decodeObject(forKey: CodingKeys.nibs.rawValue) as! [Int : NFSimpleNib]
        var nibs:[NFStandardTip : NFSimpleNib] = [:]
        for (key, value) in nibsI {  nibs[NFStandardTip.fromInt(int: key)] = value }

        self.init(overview: overview, nibs: nibs, lines: lines, glyphs: glyphs, signs: signs)
    }
    
}


public class NFElementData: NSObject, NSCoding {
    
    init(code:UInt16, origin: CGPoint) {
        self.code = code
        self.origin = origin
    }
    
    var code: UInt16
    var origin: CGPoint
    
    enum CodingKeys: String, CodingKey {
        case code
        case origin
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode( Int32(code), forKey: CodingKeys.code.rawValue)
        aCoder.encode(origin, forKey: CodingKeys.origin.rawValue)
    }
    
    public convenience required init?(coder aDecoder: NSCoder) {
        let code = aDecoder.decodeInt32(forKey: CodingKeys.code.rawValue)
        let origin = aDecoder.decodeCGPoint(forKey: CodingKeys.origin.rawValue) as! CGPoint
        
        self.init(code: UInt16(code), origin: origin)
    }
}

public class NFVerticalLayer: NSObject, NSCoding{
    
    init(vertical: Bool, layer: CALayer) {
        self.vertical = vertical
        self.layer = layer
    }
    
    var vertical: Bool
    var layer: CALayer
    
    enum CodingKeys: String, CodingKey {
        case vertical
        case layer
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(vertical, forKey: CodingKeys.vertical.rawValue)
        aCoder.encode(layer, forKey: CodingKeys.layer.rawValue)
    }
    
    public convenience required init?(coder aDecoder: NSCoder) {
        let vertical = aDecoder.decodeBool(forKey: CodingKeys.vertical.rawValue)
        let layer = aDecoder.decodeObject(forKey: CodingKeys.layer.rawValue) as! CALayer
        
        self.init(vertical: vertical, layer: layer)
    }
    
}

public class NFElementsWithWidth: NSObject, NSCoding {
    
    init(width: CGFloat, elements: [NFElementData]) {
        self.width = width
        self.elements = elements
    }
    
    var width: CGFloat
    var elements: [NFElementData]
    
    enum CodingKeys: String, CodingKey {
        case width
        case elements
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode( Float(width), forKey: CodingKeys.width.rawValue)
        aCoder.encode(elements, forKey: CodingKeys.elements.rawValue)
    }
    
    public convenience required init?(coder aDecoder: NSCoder) {
        let width = aDecoder.decodeFloat(forKey: CodingKeys.width.rawValue)
        let elements = aDecoder.decodeObject(forKey: CodingKeys.elements.rawValue) as! [NFElementData]
        
        self.init(width: CGFloat(width), elements: elements)
    }
}
