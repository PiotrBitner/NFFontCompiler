//
//  NFFont.swift
//  NFLabel
//
//  Created by Piotr Bitner on 08/02/2018.
//

/*

 Keeps NF Font features
 Used together with NFDataLibrary to create NFFontElement
 
 */

import Foundation

public enum NFFontFeatures: String{
    case  quality = "quality"
    case  boldTipScale = "boldTipScale"
    case  italicAngle = "italicAngle"
    case  lightTipScale = "lightTipScale"
    case  lightScale = "lightScale"
    case  strongTipScale = "strongTipScale"
    case  strongScale = "strongScale"
    case  hardRandom =  "hardRandom"
    case  lightRandom = "lightRandom"
    
    case lineHeight = "lineHeight"
    case  size = "size"
    case  base = "base"
    case  height = "height"
    case  ascender = "ascender"
    case  descender = "descender"
    case  capHeight = "capHeight"
    case  xHeight = "xHeight"
    case  gap = "gap"
}

public enum NFColors: String {
    
    case primaryColor = "primaryColor"
    case primaryColorLight = "primaryColorLight"
    case primaryColorDark = "primaryColorDark"
    case secondaryColor = "secondaryColor"
    case secondaryColorLight = "secondaryColorLight"
    case secondaryColorDark = "secondaryColorDark"
    
}

func defaultCase(){}

extension NFColorData{
    
    public func color() -> UIColor {
        return UIColor(red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: CGFloat(a) )
    }
    
    public func update(color: UIColor) {
        
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        color.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        self.r = Double(r)
        self.g = Double(g)
        self.b = Double(b)
        self.a = Double(a)
        
    }
}

public class NFFont {
    
    public static let quality = 0.005
    
    public var fontData: NFFontData

    public init(fontData: NFFontData) {
        self.fontData = fontData
        
        self.overview = fontData.overview
    }
    
    
    var overview: NFFontOverview
    
    var quality: CGFloat  { return CGFloat(fontData.features.quality) }
    var lineHeight: CGFloat  { return CGFloat(fontData.features.lineHeight) }

    var italicAngle: CGFloat  { return CGFloat(fontData.features.italicAngle) }
    
    var strongTipScale: CGFloat  { return CGFloat(fontData.features.strongTipScale ?? 1.0)}
    var boldTipScale: CGFloat  { return CGFloat(fontData.features.boldTipScale) }
    var lightTipScale: CGFloat  { return CGFloat(fontData.features.lightTipScale ?? 1.0 )}
    
    var lightScale: CGFloat  { return CGFloat(fontData.features.lightScale ?? 1.0)}
    var strongScale: CGFloat  { return CGFloat(fontData.features.strongScale ?? 1.0) }
    
    var hardRandom: Double { return fontData.features.hardRandom ?? 1.0 }
    var lightRandom: Double  { return fontData.features.lightRandom ?? 1.0 }
    

    public var fontDimensions: [NFFontFeatures : CGFloat] {
        
        get {
            var fd: [NFFontFeatures : CGFloat] = [:]
            
            fd[NFFontFeatures.size] = CGFloat(fontData.dimensions.size)
            fd[NFFontFeatures.base] = CGFloat(fontData.dimensions.base)
            fd[NFFontFeatures.height] = CGFloat(fontData.dimensions.height)
            fd[NFFontFeatures.ascender] = CGFloat(fontData.dimensions.ascender)
            fd[NFFontFeatures.descender] = CGFloat(fontData.dimensions.descender)
            fd[NFFontFeatures.capHeight] = CGFloat(fontData.dimensions.capHeight)
            fd[NFFontFeatures.xHeight] = CGFloat(fontData.dimensions.xHeight)
            fd[NFFontFeatures.gap] = CGFloat(fontData.dimensions.gap)
            return fd
        }
        
        set {
            for (key, value) in newValue {
                switch key {
                    
                case .size:
                    fontData.dimensions.size = Double(value)
                case .base:
                    fontData.dimensions.base = Double(value)
                case .height:
                    fontData.dimensions.height = Double(value)
                case .ascender:
                    fontData.dimensions.ascender = Double(value)
                case .descender:
                    fontData.dimensions.descender = Double(value)
                case .capHeight:
                    fontData.dimensions.capHeight = Double(value)
                case .xHeight:
                    fontData.dimensions.xHeight = Double(value)
                case .gap:
                    fontData.dimensions.gap = Double(value)
                default:
                    defaultCase()
                }
            }
        }
    }
    
    public var fontColors: [NFColors:UIColor] {
        
        get {
            var fc: [NFColors:UIColor] = [:]
            fc[NFColors.primaryColor] = fontData.colors.primaryColor.color()
            fc[NFColors.primaryColorLight] = fontData.colors.primaryColorLight?.color()
            fc[NFColors.primaryColorDark] = fontData.colors.primaryColorDark?.color()
            
            fc[NFColors.secondaryColor] = fontData.colors.secondaryColor.color()
            fc[NFColors.secondaryColorLight] = fontData.colors.secondaryColorLight?.color()
            fc[NFColors.secondaryColorDark] = fontData.colors.secondaryColorDark?.color()
            
            return fc
        }
        
        set {
            
            for (key, value) in newValue {
                switch key {
                    
                case .primaryColor:
                    fontData.colors.primaryColor.update(color: value)
                case .primaryColorLight:
                    fontData.colors.primaryColorLight?.update(color: value)
                case .primaryColorDark:
                    fontData.colors.primaryColorDark?.update(color: value)
                case .secondaryColor:
                    fontData.colors.secondaryColor.update(color: value)
                case .secondaryColorLight:
                    fontData.colors.secondaryColorLight?.update(color: value)
                case .secondaryColorDark:
                    fontData.colors.secondaryColorDark?.update(color: value)
                }
            }
        }
    }
    
    //
    // Libraries
    //
    
    public lazy var charactersLibrary: NFDataLibrary = NFDataLibrary(libraryType: .character, fontData: fontData)
    public lazy var glyphsLibrary: NFDataLibrary = NFDataLibrary(libraryType: .glyph, fontData: fontData)
    public lazy var linesLibrary: NFDataLibrary = NFDataLibrary(libraryType: .line, fontData: fontData)
    public lazy var nibsLibrary: NFDataLibrary = NFDataLibrary(libraryType: .nib, fontData: fontData)
    
    public lazy var glyphsTemplatesLibrary: NFDataLibrary = NFDataLibrary(libraryType: .glyphTemplates, fontData: fontData)
    public lazy var linesTemplatesLibrary: NFDataLibrary = NFDataLibrary(libraryType: .lineTemplates, fontData: fontData)
}

public extension NFFont {
    
    public func character(code: UInt16, libraryType: NFLibraryType = .character) -> NFFontElement?{
        let library = self.library(libraryType: libraryType)
        let character = library.get(code: code)
        // character?.fontColors = self.fontColors
        return character
    }
    
    func library(libraryType: NFLibraryType) -> NFDataLibrary{
        
        switch libraryType {
        case .character:
            return  charactersLibrary
        case .glyph:
            return glyphsLibrary
        case .line:
            return linesLibrary
        case .glyphTemplates:
            return glyphsTemplatesLibrary
        case .lineTemplates:
            return linesTemplatesLibrary
        case .nib:
            return nibsLibrary
        }
    }
}
