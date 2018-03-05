//
//  NFSimpleNib.swift
//  NFSign
//
//  Created by Piotr Bitner on 02/03/2018.
//

import Foundation

public class NFSimpleNib: NSObject, NSCoding {
    
    static let defaultRect: CGRect = CGRect(origin: CGPoint.zero, size: CGSize(width: NFNib.size2TipSize(size: defaultCharacterSize), height: NFNib.size2TipSize(size: defaultCharacterSize)) )
    static let size2tip: CGFloat = 0.08 // 0.025 //125
    
    var nibType: NFStandardTip?
    var image: CGImage?
    var size: CGFloat {
        didSet {
            rect =  CGRect(origin: CGPoint.zero, size: CGSize(width: NFNib.size2TipSize(size:size) , height: NFNib.size2TipSize(size: size) ))
        }
    }
    
    // from element

    // from element
    public var rect: CGRect = defaultRect
    
    public init(size: CGFloat, nibType: NFStandardTip?, image: CGImage? = nil) {

        self.nibType = nibType
        self.size = size
        self.image = image
        
    }
    
    enum CodingKeys: String, CodingKey {
        case nibType
        case size
        case image
    }
    
    
    
    public required convenience init?(coder aDecoder: NSCoder) {
  
        let nibTypeI = aDecoder.decodeInteger(forKey: CodingKeys.nibType.rawValue)
        let nibType = (nibTypeI == -1) ? nil : NFStandardTip.fromInt(int: nibTypeI)
        let size = aDecoder.decodeFloat(forKey: CodingKeys.size.rawValue)
        let imageN = aDecoder.decodeObject(forKey: CodingKeys.image .rawValue)
        let image = (imageN == nil) ? nil :  imageN as! CGImage
        
        self.init(size: CGFloat(size), nibType: nibType, image: image)
    }
    

    public func encode(with aCoder: NSCoder) {
        let nibTypeI = (nibType != nil) ? nibType!.rawValue : -1
        aCoder.encode( nibTypeI, forKey: CodingKeys.nibType.rawValue)
        aCoder.encode( Float(size), forKey: CodingKeys.size.rawValue)
        aCoder.encode( image, forKey: CodingKeys.image.rawValue)
    }
    
    
    public func shapePath()-> CGPath? {
        return self.nibType?.type.shape(rect)
    }

}

