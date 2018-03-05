//
//  NFSigns.swift
//  NFSign
//
//  Created by Piotr Bitner on 12/02/2018.
//

import Foundation

/*
 
 Fasade for one font family
 
 */

public class NFSigns {
    

    var font: NFFont
    
    init(font: NFFont) {
        self.font = font
    }

    var factory: NFFactory?
    
    public func signs(text: String, size: CGFloat, color: UIColor, variants: NFVariants  ) ->(signs: [NFSign]?, lineHeight: CGFloat) {
        
        
        if factory == nil {
            factory = NFFactory(font: font)
        }
        
        // deafoult nib
        let nib = getNib(size: size, nibType: variants.standardTip, image: nil)
        var ss: [NFSign] = []
        
        for code in text.utf16{
            if let fontElement = fontCharacter(code: code) {
                
                let character = self.character(fontElement: fontElement)
                
                if variants.underline {
                    if let underline = getUnderlineLine() {
                        appendLine(underline: underline , element: character)
                    }
                }
                
                character.nib = nib
                character.variants = variants
               // character.variants?.font = font
                character.font = font
                character.fontColors = font.fontColors
   
                let c = (code == 0x0020) ? UIColor.clear : color  // invisible space
                character.fontColors[NFColors.primaryColor] = c
                character.fontColors[NFColors.secondaryColor] = c
                
                let sign = self.sign(element: character, size: size)!
                ss.append(sign)
                
            }
        }
        
        // switch to main thread ?!
        // I need delegate to split function and give return later
        
        
        var lineHeight = CGFloat(font.lineHeight )
        
        lineHeight *= size  / defaultCharacterSize
        lineHeight += (nib?.rect.height ?? 0)  * size  / defaultCharacterSize
        
        return (signs: ss, lineHeight: lineHeight)
        
    }
    
    func getUnderlineLine() -> NFElement? {
        var underlineLine: NFElement?
        let underlineCode: UInt16 = 0x005F
        if let underlineFontCharacter = fontCharacter(code: underlineCode) {
            let underlineCharacter = NFElement(element: underlineFontCharacter)
            if let underlineGlyph = underlineCharacter.elements?.first {
                if let line = underlineGlyph.elements?.first {
                    underlineLine = line
                }
            }
        }
        
        return underlineLine
    }

    func appendLine(underline: NFElement, element: NFElement) {
        let glyph = element.elements?.first
        glyph?.elements?.append(underline)
 
    }
    
    static func parse(nfjson: NFJSON) -> NFFontData? {
        return NFFileParser.parse(nfjson:nfjson)
    }
    
    static func parse(data: NFFontData) -> NFFont {
        return NFFont(fontData: data)
    }
    
    func fontCharacter(code: UInt16) -> NFFontElement? {
        return factory?.character(code: code)
    }
    
    func character(fontElement: NFFontElement) -> NFElement{
        
        let element = NFElement(element: fontElement)
        element.font = font
        element.fontColors = font.fontColors
        return element
        
    }
    
    
    func getNib( size: CGFloat, nibType: NFStandardTip?, image: CGImage?, element: NFElement? = nil) -> NFNib? {
        
        var nib: NFNib?
        
        if element != nil {
            
        } else {
            nib = NFNib(size: size, nibType: nibType?.type, image: image)
        }
        
        return nib
        
    }
    
    func sign(element: NFElement, size: CGFloat) -> NFSign? {
        
        return element.createSign(size: size)
    }
}
