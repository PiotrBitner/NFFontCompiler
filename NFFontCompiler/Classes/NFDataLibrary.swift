//
//  NFDataLibrary.swift
//  NFLabel
//
//  Created by Piotr Bitner on 08/02/2018.
//

/*
 
 Used together with NFFont to create NFFontElement
 
 */

import Foundation

extension NFElementType {
    
    func nextLevel() -> NFElementType? {
        
        switch self {
        case .character:
            return .glyph
        case .glyph:
            return .line
        case .line:
            return nil
        case .nib:
            return .glyph
        }
    }
    
}

public enum NFLibraryType {
    case line, glyph, character, glyphTemplates, lineTemplates, nib
    
    public var elementType: NFElementType {
        get {
            switch self {
            case .character:
                return .character
            case .glyph:
                return .glyph
            case .line:
                return .line
            case .glyphTemplates:
                return .glyph
            case .lineTemplates:
                return .line
            case .nib:
                return .nib
                
            }
        }
    }
    
    public func nextLevel() -> NFLibraryType? {
        
        switch self {
        case .character:
            return .glyph
        case .glyph:
            return .line
        case .glyphTemplates:
            return .lineTemplates
        case .nib:
            return .glyph
        default:
            print("no nextLevel for \(self) ")
            return nil
        }
    }
    
}

public protocol NFData{ var code: UInt16 {get} }

extension NFFontElementData: NFData { }
extension NFLineData: NFData { }

public class  NFDataLibrary {
    
    public var libraryType: NFLibraryType
    public var fontData: NFFontData
    
    init(libraryType:NFLibraryType, fontData: NFFontData) {
        
        self.libraryType = libraryType
        self.fontData = fontData
    }
    
    public var elements: [NFData] {
        return fontData.elementsForLibraryType(libraryType: libraryType)
    }
    
    public var numberOfElements:Int {
        return fontData.numberOfElements(libraryType: libraryType)
    }
    
    
}


extension NFDataLibrary {
    
    public func get(code: UInt16) -> NFFontElement?  {
        
        // get root
        
        switch libraryType {
        case .character:
            if let cd = fontData.elementForCode(code: code, libraryType:libraryType) as? NFFontElementData {
                let character = NFFontElement(type: libraryType.elementType, code: code, width: cd.width, name: cd.name )
                addElements(rootElement: character, libraryType: libraryType)
                return character
            }
            
        case .glyph, .glyphTemplates:
            if let _ = fontData.elementForCode(code: code, libraryType:libraryType) as? NFFontElementData {
                let element =  NFFontElement(type: libraryType.elementType, code: code)
                addElements(rootElement: element, libraryType: libraryType)
                return element
            }
        case .line, .lineTemplates:
            if let lineData = fontData.elementForCode(code: code, libraryType:libraryType) as? NFLineData {
                let line =  NFFontElement(type: .line, code: code)
                
                addLineShapes(line: line, lineData: lineData )
                addLineChannels(line: line, lineData: lineData)
                
                return line
            }
        case .nib:
            if let _ = fontData.elementForCode(code: code, libraryType:libraryType) as? NFFontElementData {
                let element = NFFontElement(type: .nib, code: code) // NFNib(type: .nib, code: code, image: nil, size: defaultCharacterSize, tipShape: nil)
                addElements(rootElement: element, libraryType: libraryType)
                return element
            }
        }
        
        return nil
    }
    
    // create character using libraries
    func addElements(rootElement: NFFontElement, libraryType: NFLibraryType) {
        
        if let elementData = fontData.elementForCode(code: rootElement.code, libraryType:libraryType) as? NFFontElementData {
            
            let children = elementData.elements
            let childrenOrigins = elementData.origins
            
            if libraryType.elementType == .glyph{
                for index in 0..<children.count {
                    
                    let line =  NFFontElement(type: .line, code: children[index] )
                    line.rootOrigin = CGPoint(x: childrenOrigins[index].x, y: childrenOrigins[index].y)
                    line.parent = rootElement
                    
                    if rootElement.elements == nil {
                        rootElement.elements = []
                    }
                    rootElement.elements?.append(line)
                    addAllChannels(line: line, libraryType: libraryType.nextLevel()!)
                }
                
            } else {
                
                for index in 0..<children.count {
                    
                    let element = NFFontElement(type: libraryType.elementType.nextLevel()!, code: children[index] )
                    element.rootOrigin = CGPoint(x: childrenOrigins[index].x, y: childrenOrigins[index].y)
                    element.parent = rootElement
                    element.width = elementData.width
                    
                    if rootElement.elements == nil {
                        rootElement.elements = []
                    }
                    rootElement.elements?.append(element)
                    addElements(rootElement: element, libraryType: libraryType.nextLevel()!)
                }
                
            }
        }
    }
    
    func addAllChannels(line: NFFontElement, libraryType: NFLibraryType) {
        
        if let lineData = fontData.elementForCode(code: line.code, libraryType:libraryType) as? NFLineData {
           
            line.vertical = lineData.vertical
            line.name = lineData.name
            addLineShapes(line: line, lineData: lineData )
            addLineChannels(line: line, lineData: lineData)
            addLineImages(line: line, lineData: lineData )
        }
        
    }
    
    func addLineShapes(line: NFFontElement, lineData: NFLineData ) {
        let shapes = lineData.shapes
        for shape in shapes {
            
            let channelX = NFChannel(type: .positionX, interpolation: .bezier, active: true)
            channelX.vector = shape.vectorX!
            
            let channelY = NFChannel(type: .positionY, interpolation: .bezier, active: true)
            channelY.vector = shape.vectorY!
            
            let lineShapeJoint = NFShapeJoint(xChannel: channelX, yChannel: channelY, code: shape.code!, joint: .open)
            
            line.shapes.append(lineShapeJoint)
        }
        
    }
    
    func addLineChannels(line: NFFontElement, lineData: NFLineData ) {
        let channels = lineData.channels
        if line.channels == nil {   line.channels = [:] }
        for index in 0..<channels.count {
            
            let channel = NFChannel(type: channels[index].type!, interpolation: channels[index].interpolation!, active: true)
            channel.vector = channels[index].vector!
            line.channels![channels[index].type!] = channel
        }
        
    }
    
    func addLineImages(line: NFFontElement, lineData: NFLineData ) {
        var names:[String] = []
        lineData.images.forEach { (image) in
            if image != "" {
                names.append(image)
            }
        }
        
        line.images = names // make it ?
    }
}

