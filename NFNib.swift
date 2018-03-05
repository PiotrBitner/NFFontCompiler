//
//  NFNib.swift
//  NFLabel
//
//  Created by Piotr Bitner on 08/02/2018.
//

/*
 
 Nib (tip) used to create sign
 
 */

import Foundation

public typealias NibShape =  (CGRect) -> CGMutablePath


public enum NibType {
    
    case rect, circle, triangle, element
    
    var shape: NibShape {
        switch self {
        case .rect:
            return { rect in
                
                let path = CGMutablePath()
                path.addRect(rect)
                return path
            }
            
        case .circle:
            return { rect in
                
                let path = CGMutablePath()
                path.addEllipse(in: rect)
                
                return path
            }
        case .triangle:
            return { rect in
  
                let p0 = CGPoint(x: 0, y: 0)
                let p1 = CGPoint(x: rect.width, y: 0)
                let p2 = CGPoint(x: rect.width / 2, y: rect.height)
                
                let line = CGMutablePath()
                
                line.addLines(between: [p0, p1, p2, p0])
                
                return line
                
            }
        case .element:
            return { rect in return CGMutablePath() }
            
        }
    }
}


public class NFNib: NFElement {
    
    static let defaultRect: CGRect = CGRect(origin: CGPoint.zero, size: CGSize(width: NFNib.size2TipSize(size: defaultCharacterSize), height: NFNib.size2TipSize(size: defaultCharacterSize)) )
    static let size2tip: CGFloat = 0.08 // 0.025 //125
    
    static func size2TipSize(size: CGFloat) -> CGFloat{
        return size * NFNib.size2tip
    }
    
    
    public init(type:NFElementType, code: UInt16, image: CGImage?, size: CGFloat, tipShape: NibShape?) {
        
        super.init(type: type, code: code)
        
        self.tipShape = tipShape
        self.size = size
        self.image = image
    }
    
    public init( size: CGFloat, nibType: NibType?, image: CGImage?) {
        
        super.init(type: .nib, code: 0)
        
        self.tipShape = nibType?.shape
        self.size = size
        self.image = image
    }
    
    
    override public var rect: CGRect {
        didSet{
            // print("tip rect: \(rect)")
        }
    }
    
    //
    // tip
    //
    
    public init(nib: NFNib) {
        super.init(element: nib)
        
        self.size = nib.size
        self.image = nib.image
        self.tipShape = nib.tipShape
        self.rect = nib.rect
        
    }
    
    
    public var image: CGImage?
    
    public var tipShape: NibShape?
    public override var size: CGFloat {
        didSet {
            super.size = size
            rect =  CGRect(origin: CGPoint.zero, size: CGSize(width: NFNib.size2TipSize(size:size) , height: NFNib.size2TipSize(size: size) ))
        }
    }
    
    public func shapePath() -> CGMutablePath? {
        if let path = createPath() {
            var tipTransform = CGAffineTransform.identity
            let scale = scalePath2Rect(path: path, rect: rect)
            tipTransform = tipTransform.scaledBy(x: scale.scaleX, y: scale.scaleY)
            let scalledPath: CGMutablePath = CGMutablePath()
            scalledPath.addPath(path.copy(using: &tipTransform)!)
            //
            return scalledPath
        }
        
        if tipShape != nil  {
            return tipShape?(rect)
        }
        
        return nil
    }
    
    func scalePath2Rect(path: CGPath, rect:CGRect) -> (scaleX: CGFloat, scaleY: CGFloat) {
        
        let box = path.boundingBoxOfPath
        let scaleX = rect.width / box.width
        let scaleY = rect.height / box.height
        
        return (scaleX: scaleX, scaleY: scaleY)
    }
    
    public var contentImage: CGImage? {
        
        if image != nil {
            return image
        }
        
        if let i = imageFromImages() {
            return i
        }
        
        if let s = imageFromSign() {
            return s
        }
        
        return nil
    }
    
    
    public func imageFromImages() -> CGImage? {
        return nil
    }
}

extension NFElement {
    public func imageFromSign() -> CGImage?  {
        return nil
    }
    
    //
    // curve for nib
    //
    
    func createPath() -> CGMutablePath?  {
        if isLeaf {
            return createLeafPath()
        } else {
            return createElementPath()
        }
    }
    
    // size ?!
    func createLeafPath() -> CGMutablePath? {
        var path: CGMutablePath?
        let points = NFCurveEditor.pointsFromLine(line: self)
        if points.count > 0 {
            path = multiSegmentCurve(segments: points)
        }
        return path
    }
    
    func createElementPath() -> CGMutablePath? {
        let curve = CGMutablePath()
        elements?.forEach({ (element) in
            if let path =  element.createPath() {
                curve.addPath(path)
            }
        })
        
        return curve
    }
    
    func multiSegmentCurve(segments: [NFCurvePoints]) -> CGMutablePath? {
        
        let path = CGMutablePath()
        
        if let first = segments.first {
            path.move(to: first[.p0]!)
        }
        
        segments.forEach { (points) in
            path.addCurve(to: points[.p1]!, control1: points[.c0] ?? points[.p0]!, control2: points[.c1] ?? points[.p1]!)
        }
        return path
    }
}


