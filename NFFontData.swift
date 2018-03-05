//
//  NFFontData.swift
//  NFLabel
//
//  Created by Piotr Bitner on 08/02/2018.
//

/*
 
 Class with help classe for parsing NFFont JSON
 
 */

import UIKit

public class NFFontData: Codable {
    
    public var overview: NFFontOverview
    public var colors: NFFontColors
    public var features:  NFFontFeaturesData
    public var dimensions: NFFontDimensionsData
    
    public var nibs: [NFFontElementData]
    public var characters: [NFFontElementData]
    public var glyphs: [NFFontElementData]
    public var lines: [NFLineData]
    
    public var glyphTemplates: [NFFontElementData]?
    public var lineTemplates: [NFLineData]?
    
}

public class NFFontOverview: NSObject, NSCoding, Codable{
    
    public var name:String
    public var fontKind:String
    public var familyName:String
    public var author:String
    public var copyrights:String
    
    public init(name:String, fontKind:String, familyName:String, author:String, copyrights:String) {
        self.name = name
        self.fontKind = fontKind
        self.familyName = familyName
        self.author = author
        self.copyrights = copyrights
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case fontKind
        case familyName
        case author
        case copyrights
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(fontKind, forKey: .fontKind)
        try container.encode(familyName, forKey: .familyName)
        try container.encode(author, forKey: .author)
        try container.encode(copyrights, forKey: .copyrights)
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: CodingKeys.name.rawValue)
        aCoder.encode(fontKind, forKey: CodingKeys.fontKind.rawValue)
        aCoder.encode(familyName, forKey: CodingKeys.familyName.rawValue)
        aCoder.encode(author, forKey: CodingKeys.author.rawValue)
        aCoder.encode(copyrights, forKey: CodingKeys.copyrights.rawValue)
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        fontKind = try container.decode(String.self, forKey: .fontKind)
        familyName = try container.decode(String.self, forKey: .familyName)
        author = try container.decode(String.self, forKey: .author)
        copyrights = try container.decode(String.self, forKey: .copyrights)
    }
    
    public convenience required init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: CodingKeys.name.rawValue) as! String
        let fontKind = aDecoder.decodeObject(forKey: CodingKeys.fontKind.rawValue) as! String
        let familyName = aDecoder.decodeObject(forKey: CodingKeys.familyName.rawValue) as! String
        let author = aDecoder.decodeObject(forKey: CodingKeys.author.rawValue) as! String
        let copyrights = aDecoder.decodeObject(forKey: CodingKeys.copyrights.rawValue) as! String
       
        self.init(name:name, fontKind: fontKind, familyName: familyName, author: author, copyrights: copyrights)
    }
 

    
}

public class NFFontColors: Codable{
    public var primaryColor: NFColorData
    public var primaryColorLight: NFColorData?
    public var primaryColorDark: NFColorData?
    public var secondaryColor: NFColorData
    public var secondaryColorLight: NFColorData?
    public var secondaryColorDark: NFColorData?
}

public class NFColorData: Codable  {
    public var r: Double
    public var g: Double
    public var b: Double
    public var a: Double
}

public class NFFontFeaturesData: Codable{
    public var lineHeight: Double
    public var boldTipScale: Double
    public var lightTipScale: Double?
    public var lightScale: Double?
    public var strongTipScale: Double?
    public var strongScale: Double?
    public var italicAngle: Double
    public var quality: Double
    public var hardRandom: Double?
    public var lightRandom: Double?
}

public class NFFontDimensionsData: Codable{
    public var height: Double
    public var size: Double
    public var base: Double
    public var ascender: Double
    public var descender: Double
    public var capHeight: Double
    public var xHeight: Double
    public var gap: Double
}

public class NFFontElementData: Codable {
    public var code: UInt16
    // public var type:NFElementType
    public var name:String?
    public var width: Double?
    public var elements:[UInt16]
    public var origins: [NFPointData]
}

public class NFLineData: Codable{
    public var code: UInt16
   // public var type:NFElementType
    public var vertical: Bool?
    public var name:String?
    public var channels:[NFChannelData]
    public var shapes:[NFShapeData]
    public var images: [String]
   
}

public class NFPointData: Codable  {
    
    init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
    
    public var x: Double
    public var y: Double
}

public class NFChannelData: Codable {
    
    public var type: NFChannelType?
    public var interpolation: NFInterpolation?
    public var vector: NFChannelVector?
}

public class NFShapeData: Codable{
    public var code: UInt16?
    public var interpolation: NFInterpolation?
    public var vectorX: NFChannelVector?
    public var vectorY: NFChannelVector?
}

public enum NFElementType: Int, Codable {
    case line, glyph, character, nib  
}

public enum NFChannelType: Int, Codable {
    case positionX, positionY, positionZ, rotationX, rotationY, rotationZ, alpha, colors, shape, SQ
}

public enum NFInterpolation: Int, Codable {
    case bezier, linear, constant
}

public struct NFChannelVector: Codable {
    
    public var v0: Double
    public var v1: Double
    public var c0: Double?
    public var c1: Double?
    public var tc0: Double?
    public var tc1: Double?
    public var t0: Double?
    public var t1: Double?
}

extension NFFontData {
    
    func elementForCode(code: UInt16, libraryType:NFLibraryType) -> NFData? {
        var elementData: NFData?
        let elementsData = elementsForLibraryType(libraryType: libraryType)
        
        for data in elementsData {
            if data.code == code {
                elementData = data
                break
            }
        }
        return elementData
    }
    
}

public extension NFFontData {
    
    public func elementsForLibraryType(libraryType:NFLibraryType) -> [NFData] {
        
        switch libraryType {
        case .character:
            return self.characters
        case .glyph:
            return self.glyphs
        case .line:
            return self.lines
        case .glyphTemplates:
            return self.glyphTemplates ?? []
        case .lineTemplates:
            return self.lineTemplates ?? []
        case .nib:
            return self.nibs
        }
    }
    
    public func numberOfElements(libraryType:NFLibraryType) -> Int {
        
        switch libraryType {
        case .character:
            return self.characters.count
        case .glyph:
            return self.glyphs.count
        case .line:
            return self.lines.count
        case .glyphTemplates:
            return self.glyphTemplates?.count ?? 0
        case .lineTemplates:
            return self.lineTemplates?.count ?? 0
        case .nib:
            return self.nibs.count
        }
    }
}
