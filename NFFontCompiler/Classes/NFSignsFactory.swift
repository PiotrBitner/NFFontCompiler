//
//  NFSignsFactory.swift
//  NFSign
//
//  Created by Piotr Bitner on 26/02/2018.
//

import Foundation

enum NFQualityIndex: Int {
    case low, high, standard
}


typealias CodedLine = (code: UInt16, vertical: Bool, layer: CALayer)

public class NFSignsFactory {
    
    public var compiledFont: NFCompiledFont
    
    var lineCache: NFLinesCache = NFLinesCache()
    
    public init(compiledFont: NFCompiledFont) {
        
        self.compiledFont = compiledFont
    }

    
    
    public func sign(code: UInt16, variants: NFVariants, useCache: Bool = true) -> NFSign? {
    
        let cgColor = variants.color.cgColor
        var signSize = CGFloat(variants.fontSize)
        var tipSize = signSize
  
        let character = compiledFont.signs![code]!

        // b, l, s
        if variants.state != .normal {
            tipSize *= variants.tipScale
            signSize *= variants.scale
        }

        let nib = compiledFont.nibs![variants.standardTip]!
        nib.size = tipSize
        
        let scale =  (signSize / defaultCharacterSize)
        let width = (character.width + nib.rect.width ) * scale
        
        var lines: [CodedLine]  = linesForSign(code: code)
        var origins: [CGPoint] = originsForSign(code: code)
        
        var addedUnderline = false
        if variants.underline {
            let underline = getUnderline()
            if underline.line != nil && underline.origin != nil {
                addedUnderline = true
                lines.append(underline.line!)
                origins.append(underline.origin!)
            }
        }
        
        
        let cachedLines:[CALayer] = linesFromCache(lines: lines, tip: nib, quality: variants.quality, standardTip: variants.standardTip, signSize: signSize, tipSize: tipSize)

        if addedUnderline {
            scaleToWidth(line: cachedLines.last!, characterWidth: character.width + nib.rect.width)
        }

        applyOrigins(origins: origins, lines: cachedLines, scale: signSize/defaultCharacterSize)
       
        if variants.italic {
            applyItalics(angle: variants.italicAngle, codedLines: lines, lines: cachedLines)
        }
        
        applyFinish(lines: cachedLines, color: cgColor)

        let sign = signFromLines(cachedLines: cachedLines)
        sign.width = width
        
        return sign
    }
    
    func signFromLines(cachedLines:[CALayer]) -> NFSign {
        let sign = NFSign()
        sign.anchorPoint = CGPoint.zero
        sign.children = []
        
        cachedLines.forEach { (layer) in
            let subSign = NFSign()
            subSign.anchorPoint = CGPoint.zero
            subSign.addSublayer(layer)
            sign.children?.append(subSign)
            sign.addSublayer(subSign)
        }
        return sign
    }
    
 
    func getUnderline() -> (line: CodedLine?, origin: CGPoint?){

        let underlineCode: UInt16 = 0x005F
        return (line: linesForSign(code: underlineCode).first, origin: originsForSign(code: underlineCode).first )
    }
    
    func scaleToWidth(line: CALayer, characterWidth: CGFloat) {
        let underlineCode: UInt16 = 0x005F
        let underlineCharacter = compiledFont.signs![underlineCode]!
        let underlineWidth = underlineCharacter.width
        
        let scale = characterWidth / underlineWidth
        
        line.sublayers?.forEach({ (layer) in
            
            var traceTransform = layer.affineTransform()
            var tx = traceTransform.tx
            tx *= scale
       
            traceTransform.tx = tx
 
            CATransaction.setDisableActions(true)
            layer.setAffineTransform(traceTransform)
            CATransaction.commit()
        })
    }
    
    func linesFromCache(lines: [CodedLine], tip: NFSimpleNib, quality: NFQuality, standardTip: NFStandardTip, signSize: CGFloat, tipSize: CGFloat ) -> [CALayer] {
        var linesFromCache:[CALayer] = []
        for line in lines{
            let signature = NFSignature(code: line.code, quality: quality, standardTip: standardTip, signSize: signSize, tipSize: tipSize)
            var cachedLine = lineCache.cache[signature]
            if cachedLine == nil {
                //
                // copy model
                //
                cachedLine = copyModelWithSignature( line:line, tip: tip, signature: signature)
                lineCache.cache[signature] = cachedLine
            }
            let newLayer = CALayer()
            newLayer.isGeometryFlipped = true
            //
            // final copy
            //
            copyLayers(rootLayer: newLayer, sublayers: cachedLine!.sublayers as! [CAShapeLayer] )
            
            linesFromCache.append(newLayer)
        }
        return linesFromCache
    }
    
    func copyLayers(rootLayer: CALayer, sublayers: [CAShapeLayer] ) {
        
        sublayers.forEach { (shapeLayer) in
            rootLayer.addSublayer(shapeLayer.copy() as! CAShapeLayer)
        }
    }
    
    func copyModelWithSignature( line: CodedLine, tip: NFSimpleNib,  signature: NFSignature) -> CALayer {
     
        let scale = signature.signSize / defaultCharacterSize
  
        let lineLayer = line.layer

        //
        // copy
        //
        let lineLayerCopy = applyQuality(quality: signature.quality, line: lineLayer)
        
        applySize(scale: scale, line: lineLayerCopy )
        //applyTip(tip:tip, line: lineLayerCopy )
        applyNib(tip:tip, line: lineLayerCopy )

        return lineLayerCopy
        
    }
    
    
    func applyFinish(lines: [CALayer], color: CGColor, useLightRandom: Bool = false, lightRandom: CGFloat = 0.0, dim: Bool = false, dimValue: Float = 0.3) {
        lines.forEach { (layer) in
            finish(layer: layer, color: color, useLightRandom: useLightRandom, lightRandom: lightRandom, dim: dim, dimValue: dimValue)
        }
    }
    
    
    func finish(layer: CALayer, color: CGColor, useLightRandom: Bool = false, lightRandom: CGFloat = 0.0, dim: Bool = false, dimValue: Float = 0.3) {
       
            layer.sublayers?.forEach({ (la ) in
                let sl = la as! CAShapeLayer
                if useLightRandom {
                    applyRandom(range: lightRandom, layer: sl )
                }
                if color != UIColor.black.cgColor {
                    applyColor(color: color, layer: sl)
                }
 
                if dim {
                    applyDim(opacity: dimValue, line: sl )
                }
            })

    }
    
 
    func applyDim(opacity: Float, line: CALayer) {
        line.opacity = opacity
    }
    
    func applyQuality(quality: NFQuality, line: CALayer ) -> CALayer {
        
        let rootLayer = CALayer()
        rootLayer.isGeometryFlipped = true
        
        
        let lowQualityLayers = line.sublayers![0].sublayers as! [CAShapeLayer]
        let standardQualityLayers = line.sublayers![2].sublayers as! [CAShapeLayer]
        let highQualityLayers = line.sublayers![1].sublayers as! [CAShapeLayer]

        switch quality {
        case .extra:
            copyLayers(rootLayer: rootLayer, sublayers: lowQualityLayers)
            copyLayers(rootLayer: rootLayer, sublayers: standardQualityLayers)
            copyLayers(rootLayer: rootLayer, sublayers: highQualityLayers)

        case .high:
             copyLayers(rootLayer: rootLayer, sublayers: lowQualityLayers)
             copyLayers(rootLayer: rootLayer, sublayers: standardQualityLayers)
        case .normal:
            copyLayers(rootLayer: rootLayer, sublayers: lowQualityLayers)
         
        }

        return rootLayer
    }
    
 
    
    func applyOrigins(origins: [CGPoint], lines: [CALayer], scale: CGFloat) {
        for index in 0..<origins.count {
            applyOrigin(origin: origins[index], line: lines[index], scale: scale)
        }
    }
    
    func applyOrigin(origin: CGPoint, line: CALayer, scale: CGFloat) {
        
        let position =  CGPoint(x: origin.x * scale, y: origin.y * scale)
        CATransaction.setDisableActions(true)
        line.position = position
        CATransaction.commit()
    }
    
    func applyColor(color: CGColor, layer: CAShapeLayer) {
                CATransaction.setDisableActions(true)
                    layer.fillColor = color
                CATransaction.commit()
    }
    
    func applyNib(tip: NFSimpleNib, line: CALayer) {

        line.sublayers?.forEach({ (la) in
            guard let layer = la as? CAShapeLayer else { return }
            CATransaction.setDisableActions(true)
                layer.path = tip.shapePath()
                layer.contentsGravity = kCAGravityResizeAspectFill
                layer.contents = tip.image
            CATransaction.commit()
        })
    }
    
    
    func applySize(scale: CGFloat, line: CALayer) {
   
            line.sublayers?.forEach({ (layer) in
                
                var traceTransform = layer.affineTransform()
                var tx = traceTransform.tx
                tx *= scale
                
                var ty = traceTransform.ty
                ty *= scale
                
                traceTransform.tx = tx
                traceTransform.ty = ty
                
                CATransaction.setDisableActions(true)
                layer.setAffineTransform(traceTransform)
                CATransaction.commit()
            })
    }
    
    func applyItalics(angle: CGFloat, codedLines: [CodedLine], lines: [CALayer]) {
        var index = 0
        codedLines.forEach { (cl) in
            if cl.vertical {
                applyItalic(angle: angle, line: lines[index])
            }
            index += 1
        }

    }
    
    func applyItalic(angle: CGFloat, line: CALayer) {
            var traceTransform = line.affineTransform()
            traceTransform = traceTransform.rotated(by: angle )
 
            CATransaction.setDisableActions(true)
                line.setAffineTransform(traceTransform)
            CATransaction.commit()
    }
    

    func applyRandom(range: CGFloat, layer: CALayer) {
        
        NFRandomizer.dotRange = Double(range)
        
        let position = layer.position
        let xy = NFRandomizer.randomizeValues(x: position.x, y: position.y)
        
        CATransaction.setDisableActions(true)
        layer.position = CGPoint(x: xy.x, y: xy.y)
        CATransaction.commit()
    }
    
    
    
    func linesForSign(code: UInt16) -> [CodedLine]  {
        var lines: [CodedLine ] = []
        
        if let sign = compiledFont.signs?[code]?.elements {
            sign.forEach({ (elementData) in
                if let glyph = compiledFont.glyphs?[elementData.code]?.elements {
                    glyph.forEach({ (elementData) in
                        if let line = compiledFont.lines?[elementData.code] {
                            let codedLine = CodedLine(code: elementData.code, vertical: line.vertical, layer: line.layer )
                            lines.append(codedLine)
                        }
                    })
                }
            })
        }
        
        
        return lines
    }
    
    func originsForSign(code: UInt16) -> [CGPoint] {
        var origins: [CGPoint] = []
        
        if let sign = compiledFont.signs?[code]?.elements {
            sign.forEach({ (elementData) in
                let point = elementData.origin
                
                if let glyph = compiledFont.glyphs?[elementData.code]?.elements {
                    glyph.forEach({ (elementData) in
                        
                        var linePoint = elementData.origin
                        linePoint.x += point.x
                        linePoint.y += point.y
                        
                        origins.append(linePoint)
                    })
                }
            })
        }
        
        
        return origins
    }
    
}


extension CAShapeLayer: NSCopying {
    
    public func copy(with zone: NSZone? = nil) -> Any {
        
        let newLayer = CAShapeLayer()
        newLayer.bounds = self.bounds
        newLayer.opacity = self.opacity
        // newLayer.backgroundColor = UIColor.black.cgColor  // debug
        newLayer.fillColor = self.fillColor
        newLayer.strokeColor = self.strokeColor
        newLayer.setAffineTransform(self.affineTransform())
        newLayer.path = self.path?.copy()
        
        return newLayer
        
    }
}
