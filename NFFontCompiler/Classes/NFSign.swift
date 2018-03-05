//
//  NFSign.swift
//  NFLabel
//
//  Created by Piotr Bitner on 08/02/2018.
//

/*
 
 Used to create and animate sign from NFElement
 
 */

import Foundation

public protocol NFSignDelegate: class {
    func done()
}

protocol Scribeable {
    
    var index: Int {get set}
    var scribeTickTime: Double {get set}
    func hide()
    func startScribing()
    func pauseScribing()
    func stopScribing()
    func scribe()
    func scribingDone()
    
}

extension CGPoint {
    func multiply(scale: CGPoint) -> CGPoint { return CGPoint(x: scale.x * self.x, y: scale.y * self.y) }
}

extension NFElement {
    
    //
    // sign
    //
    func createSign(size: CGFloat) -> NFSign? {
        if isLeaf {
            return createLeafSign(size: size)
        } else {
            return createElementSign(size: size)
        }
    }
    
    func createElementSign(size: CGFloat) -> NFSign {
        
        let sign = NFSign()
        // NOT
        // sign.isGeometryFlipped = true
        sign.name = name
        sign.anchorPoint = CGPoint.zero

        var scaleXY = size / referenceSize //self.scale

        scaleXY *= variants?.scale ?? 1.0

        var transform = CGAffineTransform.identity
        if ( variants?.italic ?? false ){
            transform = transform.rotated(by: (variants?.italicAngle ?? 0 ) )
        }

        transform = transform.scaledBy(x:scaleXY, y: scaleXY)
        
        var origin = rootOrigin
        origin = origin.applying(transform)
   
        sign.position = origin
        
        
        sign.width = ( width == nil ) ? nil : width! * scaleXY
        sign.width! += (nib?.rect.width ?? 0) * scaleXY
        //sign.backgroundColor = UIColor.lightGray.cgColor
        
        sign.opacity = rootLayer?.opacity ?? 1.0
        sign.children = []
        // copy elements
        elements?.forEach({ (element) in
            if let subSign = element.createSign(size: size) {
                subSign.parent = sign
                sign.children?.append(subSign)
                sign.addSublayer(subSign)
            }
            
        } )
        
        return sign
        
    }
    
    func createLeafSign(size: CGFloat) -> NFSign? {
        
        let element = NFElement(element: self)
        element.size = size
        element.draw()
        
        var scaleXY = element.scale
        
        scaleXY *= variants?.scale ?? 1.0

        let sign = NFSign()
        sign.anchorPoint = CGPoint.zero
       
        var origin = rootOrigin
        
        var transform = CGAffineTransform.identity
        if ( variants?.italic ?? false ) {
            transform = transform.rotated(by: (variants?.italicAngle ?? 0 ))
        }

        transform = transform.scaledBy(x:scaleXY, y: scaleXY)
 
        origin = origin.applying(transform)

        sign.position = origin
        
        sign.isGeometryFlipped = true
        sign.opacity = rootLayer?.opacity ?? 1.0
        sign.sublayers = element.rootLayer?.sublayers  // do not copy!
        
        return sign
    }
    
    func draw() {
        if isLeaf {
            if notDrawn {
                createLayers()
            }
            updateTips()
            updateStrokePath()
            upateDims()
            upateColors()
        } else {
            elements?.forEach({ (element) in
                element.draw()
                rootLayer!.addSublayer(element.rootLayer!)
                
            })
        }
        
    }
    
    func createLayers() {
        
        var lChannels:[NFChannelType:NFChannel] = [:]
        lChannels[.SQ] = self.channels![.SQ]
        let lPlayer: NFChannelsPlayer = NFChannelsPlayer(channels: lChannels, quality: Double(quality), qualityVariant: variants?.quality ?? .normal)
        
        while !lPlayer.played {
            lPlayer.next()
            let newLayer = CAShapeLayer()
            newLayer.contentsScale = 2
            CATransaction.setDisableActions(true)
                rootLayer?.addSublayer(newLayer)
            CATransaction.commit()
        }
    }
    
    
}

public class NFSign: CALayer, Scribeable, NFTickGeneratorDelegate {
    
    public weak var signDelegate: NFSignDelegate?
    
    public var width:CGFloat?
    var parent: NFSign?
    var children:[NFSign]?
    
    public var scribingSpeed: NFScribingSpeed = .normal {
        didSet{
            children?.forEach({ (child) in
                child.scribingSpeed = scribingSpeed
            })
        }
 
    }
    
    var generator:NFTickGenerator?
    
    func info()  -> String {
        
        var text = ""
        
        if isLeaf {
            text += "\n shapelayers[\(sublayers?.count ?? 0)]"
        } else if isRoot {
            text += "\n root children[\(children?.count ?? 0)]"
        } else  {
            text += "\n children[\(children?.count ?? 0)]"
        }
        
        children?.forEach({ (element) in text += element.info()})
        return text
    }
    
    
    // protocol NFTickGeneratorDelegate: class {
    func tick() {
        if isLeaf { scribe() }
    }
    
    // Scriptable
    var index: Int = 0
    var scribeTickTime: Double = 1.0 // not used
    
    public func hide() {
        if isLeaf {
            self.sublayers?.forEach({ (layer) in
                layer.isHidden = true
            })
        }
        children?.forEach({ (child) in
            child.hide()
        })
    }
    
    public func startScribing() {
        index = 0
        scribe()
    }
    
    func scribe() {
        
        if isLeaf {
            scribeLeaf()
        } else {
            guard let _ = children else { return }
            children![index].scribe()
        }
        
    }
    public func pauseScribing() {
        generator?.pause()
        children?.forEach({ (child) in
            child.pauseScribing()
        })
    }
    
    public func stopScribing() {
        index = 0
        if isLeaf {
            generator?.stop()
            generator = nil
        } else {
            children?.forEach({ (child) in
                child.stopScribing()
            })
        }
    }
    func scribingDone() {
        
        if isLeaf {
            stopScribing()
            parent?.scribingDone()
        } else {
            index += 1
            if index < children!.count {
                scribe()
            } else {
                index = 0
                if isRoot {
                    signDelegate?.done()
                }
                parent?.scribingDone()
            }
        }
    }
    
    // speed modification !
    func scribeLeaf() {
        
        guard let trace = self.sublayers else {return}
        var delta = 0
        
        if generator == nil {
            startScribingLeaf()
        }
        
        if index > trace.count - 1 {
            scribingDone()
        } else {
            
            CATransaction.setDisableActions(true)
            
            while (delta < scribingSpeed.speed ) {
                trace[index + delta].isHidden = false
                delta += 1
                
                if index + delta > trace.count - 1  {
                    break
                }
            }
            CATransaction.commit()
            index += delta

        }
    }
    
    func startScribingLeaf() {
        if generator == nil {
            generator = NFTickGenerator()
            generator?.delegate = self
        }
        
        // hideShape()
        index = 0
        generator?.start()
    }
    
    // utilities
    var isRoot: Bool {
        return parent == nil
    }
    
    var isLeaf: Bool {
        return children == nil
    }
    
}
