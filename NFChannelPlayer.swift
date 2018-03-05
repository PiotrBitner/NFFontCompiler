//
//  NFChannelPlayer.swift
//  NFLabel
//
//  Created by Piotr Bitner on 08/02/2018.
//

/*
 
 Used together with NFChannel  to modify nib properties during travel along trajectory.
 
 */

import Foundation

typealias NFTypedValue = [NFChannelType: Double]

extension NFChannel {
    
    public func nextValue(t:Double) {
        value = value(t: t )
    }
    
    private func value(t:Double) -> Double {
        
        switch self.interpolation {
        case .constant:
            return vector.v0
        case .linear:
            return vector.v0 - (vector.v0 - vector.v1) * t
        case .bezier:
            
            let a = linear(first: vector.v0 * italic, second: vector.c0 ?? 0, t:t)
            let b = linear(first: vector.c0 ?? 0, second: vector.c1 ?? 0, t:t)
            let c = linear(first: vector.c1 ?? 0, second: vector.v1 / italic, t:t)
            
            let d = linear(first: a, second:b, t:t)
            let e = linear(first: b, second:c, t:t)
            
            return linear(first: d, second:e, t:t)
        }
    }
    
    
    private func value(t:CGFloat) -> CGPoint {
        
        switch self.interpolation {
        case .constant:
            return p0
        case .linear:
            return linear(first: p0, second: p1, t: t)
        case .bezier:
            
            let pA = linear(first: p0, second: c0, t: t)
            let pB = linear(first: c0, second: c1, t: t)
            let pC = linear(first: c1, second: p1, t: t)
            
            let pD = linear(first: pA, second: pB, t: t)
            let pE = linear(first: pB, second: pC, t: t)
            
            return linear(first: pD, second:pE, t:t)
            
        }
        
    }
    
    private func linear(first: CGPoint, second:CGPoint, t:CGFloat) ->CGPoint {
        let x = first.x - (first.x - second.x) * t
        let y = first.y - (first.y - second.y) * t
        return CGPoint(x: x, y: y)
    }
    
    private func linear(first: Double, second:Double, t:Double) -> Double {
        return first - (first - second) * t
    }
}


class NFChannelsPlayer {

    public var played = false
    public var channels:[NFChannelType:NFChannel]
    public var quality:Double
    public var qualityVariant: NFQuality = .normal
    
    // init
    init(channels:[NFChannelType:NFChannel]?, quality:Double, qualityVariant: NFQuality ) {
        
        self.qualityVariant = qualityVariant
        self.channels = channels ?? [:]
        self.quality = quality
    }
    
    private var t:Double = 0
    public func reset() {
        t = 0
        played = false
    }
    
    func nextSQ( t:Double) -> Double{
        
        if channels[.SQ]!.active {
            let channelSQ = channels[.SQ]!
            channelSQ.nextValue(t: t)
            return channelSQ.value * quality * qualityVariant.quality
        } else {
            return quality * qualityVariant.quality
        }
    }
    
    public func next()  {
        
        if played {return }
        
        nextValues(t: t)
        t += nextSQ(t: t) //quality
        
        if t >= 1 {
            played = true
        }
        
    }
    
    private func nextValues(t: Double) {
        
        for (_, channel) in channels {
            channel.nextValue(t: t)
        }
        
    }
    
    public var currentChannelsValues: NFTypedValue {
        
        get {
            var _values: NFTypedValue = [:]
            for (_, channel) in channels {
                if channel.active {
                    _values[channel.type] = channel.value
                }
                
            }
            return _values
        }
    }
    
}
