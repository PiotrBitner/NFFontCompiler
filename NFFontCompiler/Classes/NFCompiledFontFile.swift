//
//  NFCompiledFontFile.swift
//  NFSign
//
//  Created by Piotr Bitner on 02/03/2018.
//

import Foundation

public class NFCompiledFontFile {
    
    public var compiledFont: NFCompiledFont?
    
    public init() {
        
    }
    
    public init(compiledFont: NFCompiledFont) {
        self.compiledFont = compiledFont
    }
    

    public func save() {
        let fontName = compiledFont!.overview!.name
        
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(fontName).appendingPathExtension("onfc")
        
        // mapping
        NSKeyedArchiver.setClassName("NFCompiledFont", for: NFCompiledFont.self)
        NSKeyedArchiver.setClassName("NFFontOverview", for: NFFontOverview.self)
        NSKeyedArchiver.setClassName("NFSimpleNib", for: NFSimpleNib.self)
        
        NSKeyedArchiver.setClassName("NFElementsWithWidth", for: NFElementsWithWidth.self)
        NSKeyedArchiver.setClassName("NFVerticalLayer", for: NFVerticalLayer.self)
        NSKeyedArchiver.setClassName("NFElementData", for: NFElementData.self)

        NSKeyedArchiver.archiveRootObject(compiledFont!, toFile: fileURL.path)
    }

    public static func read(fontName:String) -> NFCompiledFont? {
        var compiledFont: NFCompiledFont?
        if let fileURL = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(fontName).appendingPathExtension("onfc") {
            
            print("fileURL.path: \(fileURL.path)")
            NSKeyedUnarchiver.setClass(NFCompiledFont.self, forClassName: "NFCompiledFont")
            NSKeyedUnarchiver.setClass(NFFontOverview.self, forClassName: "NFFontOverview")
            NSKeyedUnarchiver.setClass(NFSimpleNib.self, forClassName: "NFSimpleNib")
            
            NSKeyedUnarchiver.setClass(NFElementsWithWidth.self, forClassName: "NFElementsWithWidth")
            NSKeyedUnarchiver.setClass(NFVerticalLayer.self, forClassName: "NFVerticalLayer")
            NSKeyedUnarchiver.setClass(NFElementData.self, forClassName: "NFElementData")
            
            compiledFont = NSKeyedUnarchiver.unarchiveObject(withFile: fileURL.path) as? NFCompiledFont
        }
        return compiledFont
    }
    
    
}
