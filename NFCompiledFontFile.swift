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
        NSKeyedArchiver.archiveRootObject(compiledFont!, toFile: fileURL.path)
    }

    public static func read(fontName:String) -> NFCompiledFont? {
        var compiledFont: NFCompiledFont?
        if let fileURL = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(fontName).appendingPathExtension("onfc") {
            compiledFont = NSKeyedUnarchiver.unarchiveObject(withFile: fileURL.path) as? NFCompiledFont
        }
        return compiledFont
    }
    
    
}
