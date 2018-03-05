//
//  NFElement.swift
//  NFLabel
//
//  Created by Piotr Bitner on 08/02/2018.
//

/*
 
 Have methods and properties to create NFSign.
 Used for line, glyph, character and nib
 
 */

import Foundation

public class NFRootLayer: CALayer{  weak var myElement: NFElement? }

enum NFBlendMode { case standard, group, clamp }


class NFCharacterInfo {
    
    static func codeName(code:UInt16) -> String {
        return  String(Character(UnicodeScalar(code)!))
    }
    
    static func codeValue(code:UInt16) -> String {
        return  String(format:"%2X", code)
    }
    
}

extension NFElementType {
    
    public func name() -> String {
        switch self {
        case .line:
            return "line"
        case .glyph:
            return "glyph"
        case .character:
            return "character"
        case .nib:
            return "nib"
            
        }
    }
    
    public func title() -> String {
        switch self {
            
        case .character:
            return  "Character"
        case .glyph:
            return  "Glyph"
        case .line:
            return  "Line"
        case .nib:
            return "Nib"
        }
    }
}

public class NFElement {
    
    public var code: UInt16
    public var shapes: [NFShapeJoint]
    public var images: [String]
    
    public var rootLayer:NFRootLayer?
    
    public var font:NFFont? {
        didSet {
            if variants == nil {
                variants = NFVariants()
            }
            //variants!.font = font
            elements?.forEach({ (element) in element.font = font })
        }
    }
    
    public var variants: NFVariants? {
        didSet {
            // if leaf update?
            elements?.forEach({ (element) in element.variants = variants })
        }
    }
    
    public init(element: NFFontElement, parent: NFElement?=nil ) {
        self.code = element.code
        self.shapes = element.shapes
        self.images = element.images
        self.channels = element.channels
        self.parent = parent
        self.name = element.name
        self.vertical = element.vertical
        
        
        
        self.width =  (element.width == nil) ? nil :  CGFloat(element.width!)
        
        if element.elements != nil {
            self.elements = []
            element.elements?.forEach({ (el) in
                self.elements!.append(NFElement(element: el, parent: self))
            })
        }
      
        self.rootOrigin = element.rootOrigin
    }
    
    public init(type:NFElementType, code: UInt16) {
        self.code = code
        self.shapes = []
        self.images = []
        self.rootLayer = NFRootLayer()
        self.rootLayer!.anchorPoint = CGPoint.zero
        self.rootLayer!.backgroundColor = UIColor.red.cgColor
        
        self.rootLayer!.contentsScale = 2
        self.rootLayer!.opacity = 1.0
        self.rootLayer!.allowsGroupOpacity = true
        
    }
    
    init(element: NFElement) {
        
        self.code = element.code
        self.shapes = element.shapes
        self.images = element.images
        self.font = element.font
        self.width = element.width
        self.name = element.name
        self.vertical = element.vertical
        
        self.variants = element.variants
        
        // new root layer
        self.rootLayer = NFRootLayer()
        self.rootLayer!.anchorPoint = CGPoint.zero
        self.rootLayer!.backgroundColor = UIColor.red.cgColor
        
        self.rootLayer!.contentsScale = 2
        self.rootLayer!.opacity = element.rootLayer?.opacity ?? 1.0
        self.rootLayer!.allowsGroupOpacity = element.rootLayer?.allowsGroupOpacity ?? true
        
        self.nib = element.nib
        self.parent = element.parent
        self.elements = element.elements
        
        self.channels = element.channels
        self.scale = element.scale
        self.referenceSize = element.referenceSize
        
        self.rootOrigin = element.rootOrigin
   
        self.fontColors = element.fontColors
        
    }
    
    public var nib: NFNib? {
        didSet {
            if isLeaf {
                updateTips()
            } else {
                elements?.forEach({ (element) in element.nib = nib})
            }
        }
    }
    
    public var vertical: Bool?{
        didSet {
            if !isLeaf {
                elements?.forEach({ (element) in element.vertical = vertical})
            }
        }
    }
    
    public var rootOrigin:CGPoint = CGPoint.zero
    
  
    
    var blendMode: NFBlendMode = .standard
    public var width:CGFloat?
    
    var quality: CGFloat { return font?.quality ?? CGFloat(NFFont.quality) }
    
    public var parent:NFElement?
    public var elements: [NFElement]?
    public var channels:[NFChannelType:NFChannel]?
    
    public var isRoot: Bool {  return parent == nil }
    public var isLeaf: Bool { return elements == nil }
    public var notDrawn: Bool { return (rootLayer?.sublayers?.count ?? 0) == UInt(0) }
    public var rect: CGRect = CGRect.zero
    public var scale: CGFloat = 1.0
    public var size: CGFloat = 12 {
        didSet {
            scale = size / referenceSize
            elements?.forEach({ (element) in element.size = size })
        }
    }
    
    var referenceSize: CGFloat = CGFloat(defaultCharacterSize) {
        didSet { scale = size / referenceSize }
    }
    
    public var fontColors: [NFColors:UIColor] = [:]
        {
        didSet {
            if isLeaf {upateColors()}
            elements?.forEach({ (element) in element.fontColors = fontColors })
        }
    }

    var numberOfShapes: Int { return shapes.count }
    
    var name: String?
    
}

extension NFElement {
    
    func getChannel(type: NFChannelType ) -> NFChannel? { return channels?[type] }
    
    func addAllChannels() {
        channels = [:]
        
        channels![.positionZ] = NFChannel(type: .positionZ, interpolation: .linear)
        channels![.rotationX] = NFChannel(type: .rotationX, interpolation: .linear)
        channels![.rotationY] = NFChannel(type: .rotationY, interpolation: .linear)
        channels![.rotationZ] = NFChannel(type: .rotationZ, interpolation: .linear)
        channels![.colors]    = NFChannel(type: .colors, interpolation: .linear)
        channels![.alpha]     = NFChannel(type: .alpha, interpolation: .linear)
        channels![.SQ]        = NFChannel(type: .SQ, interpolation: .constant)
        
    }
    
    //
    // shapes
    //
    
    func channelsForShape(index: Int) -> [NFChannelType:NFChannel] {
        let shape = shapes[index]
        var channels: [NFChannelType:NFChannel] = [:]
        channels[.positionX] = shape.xChannel
        channels[.positionY] = shape.yChannel
        channels[.SQ] = self.channels![.SQ]
        return channels
    }
}


// for basic sign
extension NFElement {

    func createModel() -> CALayer {
        
        
        let rootLayer = CALayer()
        let lowQualityLayer = CALayer()
        let standardQualityLayer = CALayer()
        let highQualityLayer = CALayer()
        
        rootLayer.isGeometryFlipped = true
        
        rootLayer.addSublayer(lowQualityLayer)
        rootLayer.addSublayer(highQualityLayer)
        rootLayer.addSublayer(standardQualityLayer)
        
        var lChannels:[NFChannelType:NFChannel] = [:]
        lChannels[.SQ] = self.channels![.SQ]
        let lPlayer: NFChannelsPlayer = NFChannelsPlayer(channels: lChannels, quality: Double(quality), qualityVariant: .extra)
        
        var switcher = 0
        
        while !lPlayer.played {
            lPlayer.next()
            let newLayer = CAShapeLayer()
            newLayer.contentsScale = 2
            
            // no need for tip!
           // applyTip(layer: newLayer)
            
            CATransaction.setDisableActions(true)
            
            if switcher == 0 {
                lowQualityLayer.addSublayer(newLayer)
            } else if switcher == 2 {
                standardQualityLayer.addSublayer(newLayer)
            } else if switcher == 1 || switcher == 3 {
                highQualityLayer.addSublayer(newLayer)
            }
            
            switcher += 1
            
            if switcher == 4 {switcher = 0}
            
            CATransaction.commit()
        }
        
        moveAndRotate(rootLayer: rootLayer)
        
        return rootLayer
    }
    
    func applyTip(layer: CAShapeLayer) {
        
        guard let tip = self.nib else {return}
        CATransaction.setDisableActions(true)
        layer.bounds = tip.rect
        layer.path = nil
        layer.contents = nil
        
        if let shape = tip.shapePath() {
            layer.path = shape }
        if let image = tip.contentImage {
            layer.contentsGravity = kCAGravityResizeAspectFill // kCAGravityCenter
            layer.contents = image
        }
        
        CATransaction.commit()
        
    }
   
    
    func moveAndRotate(rootLayer: CALayer) {
 
        let lowQualityLayer = rootLayer.sublayers![0]
        let standardQualityLayer = rootLayer.sublayers![2]
        let highQualityLayer = rootLayer.sublayers![1]
        
        var currentShapeIndex = 0
        
        var lChannels:[NFChannelType:NFChannel] = [:]
        lChannels[.SQ] = self.channels![.SQ]
        lChannels[.positionZ] = self.channels![.positionZ]
        lChannels[.rotationX] = self.channels![.rotationX]
        lChannels[.rotationY] = self.channels![.rotationY]
        lChannels[.rotationZ] = self.channels![.rotationZ]
        
        // line player
        let lPlayer: NFChannelsPlayer = NFChannelsPlayer(channels: lChannels, quality: Double(quality), qualityVariant: .extra)
        
        // shape player
        var forShape = channelsForShape(index: currentShapeIndex)
        
        // shape randomization
        if (variants?.useHardRandom ?? false) {
            NFRandomizer.shapeRange = variants!.hardRandom // scale?
            forShape = NFRandomizer.randomizeShape(channels: forShape) // I need copy here!
        }
        
        let shapePlayer = NFChannelsPlayer(channels: forShape, quality:  Double( CGFloat(numberOfShapes)  * self.quality ), qualityVariant: .extra)
        
        var index = 0
        var switcher = 0
        var lowQualityIndex = 0
        var standardQualityIndex = 0
        var highQualityIndex = 0
        
        while !lPlayer.played {
            lPlayer.next()
            shapePlayer.next()
            
            var values = lPlayer.currentChannelsValues
            let shapeValues = shapePlayer.currentChannelsValues
            values[.positionX] = shapeValues[.positionX]
            values[.positionY] = shapeValues[.positionY]
            
            if shapePlayer.played {
                if currentShapeIndex < shapes.count - 1 {
                    currentShapeIndex += 1
                    shapePlayer.reset()
                    shapePlayer.channels = channelsForShape(index: currentShapeIndex)
                }
            }
            
            // update required layer!
            var layer: CALayer?
            
            if switcher == 0 {
                layer = lowQualityLayer.sublayers![lowQualityIndex]
                lowQualityIndex += 1
            } else if switcher == 2 {
                layer = standardQualityLayer.sublayers![standardQualityIndex]
                standardQualityIndex += 1
            } else if switcher == 1 || switcher == 3 {
               layer =  highQualityLayer.sublayers![highQualityIndex]
                highQualityIndex += 1
            }
            
            switcher += 1
            
            if switcher == 4 {switcher = 0}
            
            updateMoveAndRotate(layer: layer! as! CAShapeLayer, typedValues: values )
            index += 1
        }
    }
    
    func updateMoveAndRotate(layer: CAShapeLayer, typedValues: NFTypedValue) {
        
        //   layer.backgroundColor = UIColor.blue.cgColor  // for debug
        var traceTransform = CGAffineTransform.identity
        
        var x = CGFloat(typedValues[.positionX] ?? 0)
        var y = CGFloat(typedValues[.positionY] ?? 0)
        
        x *= scale
        y *= scale
        
        x *= variants?.scale ?? 1.0
        y *= variants?.scale ?? 1.0
        
        
        if ( variants?.italic ?? false ) && ( vertical ?? false ) {
            traceTransform = traceTransform.rotated(by: -(variants?.italicAngle ?? 0 ) )
        }
        
        // dots randomization
        
        if (variants?.useLightRandom ?? false) {
            NFRandomizer.dotRange = variants!.lightRandom // scale?
            
            let xy = NFRandomizer.randomizeValues(x: x, y: y)
            x = xy.x
            y = xy.y
        }
        
        traceTransform = traceTransform.translatedBy(x: x , y: y)
        
        if let v = typedValues[.positionZ] { traceTransform = traceTransform.scaledBy(x: scale * CGFloat(v) , y: scale * CGFloat(v)) }
        if let v = typedValues[.rotationX] { traceTransform = traceTransform.scaledBy(x: CGFloat(v) , y: 1.0) }
        if let v = typedValues[.rotationY] { traceTransform = traceTransform.scaledBy(x: 1.0, y: CGFloat(v)) }
        if let v = typedValues[.rotationZ] { traceTransform = traceTransform.rotated(by: CGFloat(v)) }
        
        traceTransform = traceTransform.scaledBy(x: variants?.tipScale ?? 1.0, y: variants?.tipScale ?? 1.0 )
        
        CATransaction.setDisableActions(true)
            layer.setAffineTransform(traceTransform)
        CATransaction.commit()
        
    }
    
}

extension NFElement {
    
    
    func updateStrokePath() {
        
        if shapes.count == 0 { return }
        
        var currentShapeIndex = 0
        
        var lChannels:[NFChannelType:NFChannel] = [:]
        lChannels[.SQ] = self.channels![.SQ]
        lChannels[.positionZ] = self.channels![.positionZ]
        lChannels[.rotationX] = self.channels![.rotationX]
        lChannels[.rotationY] = self.channels![.rotationY]
        lChannels[.rotationZ] = self.channels![.rotationZ]
        
        // line player
        let lPlayer: NFChannelsPlayer = NFChannelsPlayer(channels: lChannels, quality: Double(quality), qualityVariant: variants?.quality ?? .normal)
        
        // shape player
        var forShape = channelsForShape(index: currentShapeIndex)
        
        // shape randomization
        if (variants?.useHardRandom ?? false) {
            NFRandomizer.shapeRange = variants!.hardRandom // scale?
            forShape = NFRandomizer.randomizeShape(channels: forShape) // I need copy here!
        }

        let shapePlayer = NFChannelsPlayer(channels: forShape, quality:  Double( CGFloat(numberOfShapes)  * self.quality ), qualityVariant: variants?.quality ?? .normal)
        
        var index = 0
        while !lPlayer.played {
            lPlayer.next()
            shapePlayer.next()
            
            var values = lPlayer.currentChannelsValues
            let shapeValues = shapePlayer.currentChannelsValues
            values[.positionX] = shapeValues[.positionX]
            values[.positionY] = shapeValues[.positionY]
            
            if shapePlayer.played {
                if currentShapeIndex < shapes.count - 1 {
                    currentShapeIndex += 1
                    shapePlayer.reset()
                    shapePlayer.channels = channelsForShape(index: currentShapeIndex)
                }
            }
            
            updateStrokePath(typedValues: values, index: index)
            index += 1
        }
        
    }
    
    func updateStrokePath(typedValues: NFTypedValue, index:Int) {
        
        guard let layer = rootLayer?.sublayers?[index] as? CAShapeLayer else { return}

        //   layer.backgroundColor = UIColor.blue.cgColor  // for debug
        var traceTransform = CGAffineTransform.identity
    
        var x = CGFloat(typedValues[.positionX] ?? 0)
        var y = CGFloat(typedValues[.positionY] ?? 0)
        
        x *= scale
        y *= scale
        
        x *= variants?.scale ?? 1.0
        y *= variants?.scale ?? 1.0
        

        if ( variants?.italic ?? false ) && ( vertical ?? false ) {
            traceTransform = traceTransform.rotated(by: -(variants?.italicAngle ?? 0 ) )
        }

        // dots randomization
        
        if (variants?.useLightRandom ?? false) {
            NFRandomizer.dotRange = variants!.lightRandom // scale?
            
            let xy = NFRandomizer.randomizeValues(x: x, y: y)
            x = xy.x
            y = xy.y
        }
   
        traceTransform = traceTransform.translatedBy(x: x , y: y)

        if let v = typedValues[.positionZ] { traceTransform = traceTransform.scaledBy(x: scale * CGFloat(v) , y: scale * CGFloat(v)) }
        if let v = typedValues[.rotationX] { traceTransform = traceTransform.scaledBy(x: CGFloat(v) , y: 1.0) }
        if let v = typedValues[.rotationY] { traceTransform = traceTransform.scaledBy(x: 1.0, y: CGFloat(v)) }
        if let v = typedValues[.rotationZ] { traceTransform = traceTransform.rotated(by: CGFloat(v)) }
        
        traceTransform = traceTransform.scaledBy(x: variants?.tipScale ?? 1.0, y: variants?.tipScale ?? 1.0 )
        
        CATransaction.setDisableActions(true)
            layer.setAffineTransform(traceTransform)
        CATransaction.commit()
        
    }
    
    
    //
    // colors
    //
    

    
    func upateColors() {
        
        if notDrawn {return}
        
        guard  let sq = self.channels![.SQ] else {return}
        
        let alpha =  self.channels![.alpha]
        let colors = self.channels![.colors]
        
        var cChannels:[NFChannelType:NFChannel] = [:]
        cChannels[.alpha] = alpha
        cChannels[.colors] = colors
        cChannels[.SQ] = sq
        
        
        let cPlayer: NFChannelsPlayer = NFChannelsPlayer(channels: channels, quality:Double( quality), qualityVariant: variants?.quality ?? .normal)
        
        var fColor =  fontColors[NFColors.primaryColor] 
        var sColor =  fontColors[NFColors.secondaryColor]
        
        if variants?.state == .light {
            fColor = fontColors[NFColors.primaryColorLight] ?? fontColors[NFColors.primaryColor]?.lighter() ?? UIColor.lightGray
            sColor = fontColors[NFColors.secondaryColorLight] ?? fontColors[NFColors.secondaryColor]?.lighter() ?? UIColor.lightGray
        } else if variants?.state == .strong {
            fColor =  fontColors[NFColors.primaryColorDark] ?? fontColors[NFColors.primaryColor]?.darker() ?? UIColor.lightGray
            sColor =  fontColors[NFColors.secondaryColorDark] ?? fontColors[NFColors.secondaryColor]?.darker() ?? UIColor.lightGray
        }
        
        var index = 0
        while !cPlayer.played {
            cPlayer.next()
            let values = cPlayer.currentChannelsValues
            updateColor(firstColor: fColor!, secondColor: sColor, typedValues: values, index: index)
            index += 1
        }
    }
    
    
    
    func updateColor(firstColor: UIColor, secondColor: UIColor?, typedValues: NFTypedValue, index:Int) {
        
        guard let layer = rootLayer?.sublayers?[index] as? CAShapeLayer else { return}
        
        var colors: CGFloat = 1.0
        
        if let v = typedValues[.colors] { colors = CGFloat(v) }
        
        var alpha: CGFloat = 0.1
        if let v = typedValues[.alpha] { alpha *= CGFloat(v) }
        
        let mixAlpha =  (blendMode == .standard )
        
        var color:UIColor
        if secondColor != nil {
            color = NFColor.mixColors(firstColor: firstColor, secondColor: secondColor!, mixValue: colors, alpha: alpha, mixAlpha: mixAlpha )
        } else {
            color = firstColor
        }
        
        
        CATransaction.setDisableActions(true)
            layer.fillColor = color.cgColor
        CATransaction.commit()
        
    }
    
    //
    // dims
    //
    
    func upateDims() {
        rootLayer?.opacity = (variants?.dim ?? false ) ? 0.3 : 1.0
    }
    
    //
    // tip
    //
    
    
    func updateTips() {
        
        guard let tip = self.nib else {return}
        
        rootLayer?.sublayers?.forEach({ (la ) in
            
            let layer = la as! CAShapeLayer
            
            CATransaction.setDisableActions(true)
            layer.bounds = tip.rect
            layer.path = nil
            layer.contents = nil
            
            if let shape = tip.shapePath() {
                layer.path = shape }
            if let image = tip.contentImage {
                layer.contentsGravity = kCAGravityResizeAspectFill // kCAGravityCenter
                layer.contents = image
            }
            
            CATransaction.commit()
            
        })
    }
    
}

extension UIColor {
    /**
     Create a ligher color
     */
    func lighter(by percentage: CGFloat = 30.0) -> UIColor {
        return self.adjustBrightness(by: abs(percentage))
    }
    
    /**
     Create a darker color
     */
    func darker(by percentage: CGFloat = 30.0) -> UIColor {
        return self.adjustBrightness(by: -abs(percentage))
    }
    
    /**
     Try to increase brightness or decrease saturation
     */
    func adjustBrightness(by percentage: CGFloat = 30.0) -> UIColor {
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        if self.getHue(&h, saturation: &s, brightness: &b, alpha: &a) {
            if b < 1.0 {
                let newB: CGFloat = max(min(b + (percentage/100.0)*b, 1.0), 0,0)
                return UIColor(hue: h, saturation: s, brightness: newB, alpha: a)
            } else {
                let newS: CGFloat = min(max(s - (percentage/100.0)*s, 0.0), 1.0)
                return UIColor(hue: h, saturation: newS, brightness: b, alpha: a)
            }
        }
        return self
    }
}
