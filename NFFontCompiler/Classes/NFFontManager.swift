//
//  NFFontManager.swift
//  NFSign
//
//  Created by Piotr Bitner on 14/02/2018.
//

import Foundation

public let nfFontManager  = NFFontManager()

public class NFFontManager {
    
    public var fontNames:[String] = []

    public init() {
        self.fontNames.append("Aramejski")
    }
    
    //public var fonts:[String:NFSigns]?
    public var fonts:[String:NFSignsFactory]?
    
    public func addFont(fontName: String) -> NFSignsFactory? {
        if fonts == nil {fonts = [:]}
        if fontNames.contains(fontName) {
            if let fontData = NFSigns.parse(nfjson: simpletJSON) {
                if fonts![fontName] == nil {
                    let font = NFSigns.parse(data: fontData)
                    if let compiledFont = compileFont(font: font) {
                        let factory = NFSignsFactory(compiledFont: compiledFont)
                        // let signs = NFSigns(font: font)
                        fonts![fontName] = factory
                    }
                }
            }
        }
        
        return fonts![fontName] 
    }
    

    func compileFont(font: NFFont) -> NFCompiledFont?{
        
        let compiler = NFFontCompiler(font:font)
        compiler.compile()
        
        return compiler.compliedFont
        
    }
    
    
    public func getFont(fontName: String) -> NFFont? {
        var font: NFFont?
        if fontNames.contains(fontName) {
            if let fontData = NFSigns.parse(nfjson: simpletJSON) {
                    font = NFSigns.parse(data: fontData)
            }
        }
        
        return font
    }
    
    public func removeFont(fontName: String) {
        
    }
    
    public func cleanFonts() {
        
    }
}
