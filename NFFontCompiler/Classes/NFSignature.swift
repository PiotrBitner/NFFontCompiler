//
//  NFSignature.swift
//  NFSign
//
//  Created by Piotr Bitner on 01/03/2018.
//

import Foundation

class NFSignature: Hashable {
    
    var code: UInt16
    var standardTip: NFStandardTip
    var signSize: CGFloat
    var tipSize: CGFloat
    var quality: NFQuality
    
    init(code: UInt16, quality: NFQuality, standardTip: NFStandardTip, signSize: CGFloat, tipSize: CGFloat) {
        self.code = code
        self.quality = quality
        self.standardTip = standardTip
     
        self.signSize = signSize
        self.tipSize = tipSize
        
    }
    
    
    func createSignature() -> String{
        let tip = standardTip.codeLetter
        let q = quality.codeLetter
        return "\(code)\(q)\(signSize)\(tip)\(tipSize)"
    }
    
    var hashValue: Int {return createSignature().hashValue}
    
    static func == (lhs: NFSignature, rhs: NFSignature) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
