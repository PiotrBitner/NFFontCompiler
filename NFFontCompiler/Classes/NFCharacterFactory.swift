//
//  NFCharacterFactory.swift
//  NFLabel
//
//  Created by Piotr Bitner on 08/02/2018.
//

import Foundation

public class NFFactory {
    
    var font: NFFont
    
    public init(font: NFFont) {
        self.font = font
    }
    
    var characters: [UInt16: NFFontElement] = [:]
    
    public func character(code: UInt16) -> NFFontElement? {
     
        if characters[code] == nil {
            DispatchQueue.global().sync { characters[code] = font.character(code: code)}
        }

        // I need hard random here?!
        
        return characters[code]
    }
}
