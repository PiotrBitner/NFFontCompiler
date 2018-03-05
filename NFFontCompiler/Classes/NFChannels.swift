//
//  NFChannels.swift
//  NFLabel
//
//  Created by Piotr Bitner on 08/02/2018.
//

/*

 Used together with NFChannelPlayer to modify nib properties during travel along trajectory.
 
 */

import Foundation

public enum NFJoint: Int, Codable { case open, corner, smooth, symetric }

public class NFShapeJoint {
    
    public var code: UInt16
    public var codeValue: String { return "" }
    public var xChannel: NFChannel
    public var yChannel: NFChannel
    public var joint: NFJoint
    public var interpolation: NFInterpolation
    
    public init(xChannel: NFChannel, yChannel: NFChannel, code: UInt16, interpolation: NFInterpolation = .bezier, joint: NFJoint = .open) {
        self.code = code
        self.interpolation = interpolation
        self.xChannel = xChannel
        self.yChannel = yChannel
        self.joint = joint
    }
    
    var shapeChannel: NFVirtualChannelXY?
}

public class NFChannel {
    
    
    public var type: NFChannelType
    public var interpolation: NFInterpolation
    
    public var locked = false
    public var active = false
    
    public var italic: Double = 1.0
    public var value:Double = 0.0
    
    public var vector: NFChannelVector = NFChannelVector(v0: 0.0, v1: 0.0, c0: 0.0, c1: 0.0, tc0: 0.0, tc1: 0.0, t0: 0.0, t1: 1.0)
    
    public init(type: NFChannelType, interpolation: NFInterpolation = .linear, active:Bool = false) {
        
        self.type = type
        self.interpolation = interpolation
        
        self.active = active
        
    }
    
    public init(channel: NFChannel) {
        
        self.type = channel.type
        self.interpolation = channel.interpolation
        self.locked = channel.locked
        self.active = channel.active
        self.vector = channel.vector
        
    }
    
    var p0: CGPoint {
        get { return CGPoint(x: vector.t0 ?? 0 , y: vector.v0) }
        set {
            vector.t0 = Double( newValue.x )
            vector.v0 = Double( newValue.y )
        }
    }
    
    var p1: CGPoint {
        get { return CGPoint(x: vector.t1 ?? 1, y: vector.v1 ) }
        set {
            vector.t1 = Double( newValue.x )
            vector.v1 = Double( newValue.y )
        }
    }
    
    var c0: CGPoint {
        get { return CGPoint(x: vector.tc0 ?? 0, y: vector.c0 ?? 0) }
        set {
            vector.tc0 = Double( newValue.x )
            vector.c0 = Double( newValue.y )
        }
    }
    
    var c1: CGPoint {
        get { return CGPoint(x: vector.tc1 ?? 0, y: vector.c1 ?? 0) }
        set {
            vector.tc1 = Double( newValue.x )
            vector.c1 = Double( newValue.y )
        }
    }
    
}



class NFVirtualChannelXY: NFChannel {
    
    var channelX: NFChannel?
    var channelY: NFChannel?
}
