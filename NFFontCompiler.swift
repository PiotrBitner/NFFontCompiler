//
//  NFFontCompiler.swift
//  NFSign
//
//  Created by Piotr Bitner on 26/02/2018.
//

import Foundation

public class NFFontCompiler {
    
    var font: NFFont
    
    public init(font: NFFont) {
        self.font = font
    }
    
    let variants: NFVariants = NFVariants()
    
    public var compliedFont: NFCompiledFont?
    
    
    public func compile() {
        
        compliedFont = NFCompiledFont()
        
        compileLines()
        complieGlyphs()
        complieSigns()
        complieNibs() 
        addOverview()
    }
    
    func addOverview() {
        compliedFont?.overview = font.overview
    }
    

    func complieNibs() {
        var tips: [NFStandardTip : NFSimpleNib] = [:]
        tips[.circle] =  NFSimpleNib(size: defaultCharacterSize, nibType: .circle)
        tips[.square] = NFSimpleNib(size: defaultCharacterSize, nibType: .square)
        tips[.triangle] = NFSimpleNib(size: defaultCharacterSize, nibType: .triangle)
        
        compliedFont?.nibs = tips
    }
    
    func complieGlyphs() {
        var glyphs: NFCompliedElement = [:]
        let library = font.glyphsLibrary
        let elements = library.elements
        
        for elementData in elements {
            // let element =  NFFontElement(type: .glyph, code: elementData.code)
            
            glyphs[elementData.code] = NFElementsWithWidth(
                    width: CGFloat((elementData as! NFFontElementData).width ?? 0),
                    elements: complieElementData(
                        codes: (elementData  as! NFFontElementData).elements,
                        origins: (elementData  as! NFFontElementData).origins
                    )
            )
        }
        
        compliedFont?.glyphs = glyphs
    }
    
    func complieSigns() {
        var signs: NFCompliedElement = [:]
        let library = font.charactersLibrary
        let elements = library.elements
        
        for elementData in elements {
            signs[elementData.code] = NFElementsWithWidth(
                    width: CGFloat((elementData as! NFFontElementData).width ?? 0),
                    elements: complieElementData(
                codes: (elementData  as! NFFontElementData).elements,
                origins: (elementData  as! NFFontElementData).origins
            )
            )
        }
        
        compliedFont?.signs = signs
    }
    
    func complieElementData(codes:[UInt16], origins:[NFPointData]) -> [NFElementData] {
        var elementsData: [NFElementData] = []
        var elementData: NFElementData
        for index in 0..<codes.count {
            elementData =   NFElementData(code: codes[index], origin: CGPoint(x: origins[index].x, y: origins[index].y))   //      (code: codes[index], origin: CGPoint(x: origins[index].x, y: origins[index].y))
            elementsData.append(elementData)
        }
        
        return elementsData
    }

    func compileLines() {
        
        var lines: NFCompiledLines = [:]
        
        let linesLibrary = font.linesLibrary
        let elements = linesLibrary.elements
        let nib = getNib(size: defaultCharacterSize, nibType: variants.standardTip, image: nil)
        
        for elementData in elements {
            
            let line =  NFFontElement(type: .line, code: elementData.code)
            linesLibrary.addLineShapes(line: line, lineData: elementData as! NFLineData )
            linesLibrary.addLineChannels(line: line, lineData: elementData as! NFLineData )
            
            let lineElement = NFElement(element: line)
            lineElement.font = font
            lineElement.variants = variants
            lineElement.fontColors = font.fontColors
            lineElement.nib = nib
            
            let signModel = lineElement.createModel()
            lines[elementData.code] = NFVerticalLayer(vertical: (elementData as! NFLineData).vertical ?? false, layer: signModel)
        }
        
        compliedFont?.lines = lines
        
    }
    
    func getNib( size: CGFloat, nibType: NFStandardTip?, image: CGImage?, element: NFElement? = nil) -> NFNib? {
        
        var nib: NFNib?
        
        if element != nil {
            
        } else {
            nib = NFNib(size: size, nibType: nibType?.type, image: image)
        }
        
        return nib
        
    }
}
