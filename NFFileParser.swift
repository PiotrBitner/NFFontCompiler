//
//  NFFileParser.swift
//  NFLabel
//
//  Created by Piotr Bitner on 08/02/2018.
//

import Foundation

public typealias NFJSON = [String:AnyObject]

public class NFFileParser {
    
    public static func parse(nfjson: NFJSON) -> NFFontData? {
        var fontData: NFFontData?
        DispatchQueue.global().sync {
            let jsonData: Data = try! JSONSerialization.data(withJSONObject: nfjson)
            let jsonDecoder = JSONDecoder()
            fontData = try? jsonDecoder.decode( NFFontData.self, from: jsonData)
        }
        return fontData
    }
}
