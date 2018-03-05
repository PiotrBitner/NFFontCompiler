//
//  NFFontElement.swift
//  NFLabel
//
//  Created by Piotr Bitner on 08/02/2018.
//

import Foundation

public let defaultCharacterSize:CGFloat = 12.0

public class NFFontElement {
    
    public var code: UInt16
    public var type:NFElementType
    public var shapes: [NFShapeJoint]
    public var images: [String]
    public var width: Double?
    public var name: String?
    public var vertical: Bool?
    
    public init(element: NFFontElement ) {
        self.code = element.code
        self.type = element.type
        self.shapes = element.shapes
        self.images = element.images
        self.width = element.width
        self.name = element.name
        self.vertical = element.vertical
        
        self.parent = element.parent
        self.elements = element.elements
    }
    
    public init(type:NFElementType, code: UInt16, width:Double? = nil, name: String? = nil) {
        self.code = code
        self.type = type
        self.width = width
        self.name = name
        self.shapes = []
        self.images = []
    }
    
    public var rootOrigin:CGPoint = CGPoint.zero
    
    public var parent:NFFontElement?
    public var elements: [NFFontElement]?
    public var channels:[NFChannelType:NFChannel]?
}

