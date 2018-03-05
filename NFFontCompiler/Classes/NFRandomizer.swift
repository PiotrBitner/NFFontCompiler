//
//  NFRandomizer.swift
//  NFSign
//
//  Created by Piotr Bitner on 21/02/2018.
//

import Foundation


class NFRandomizer {
    
    static var shapeRange: Double = 1.1
    static var dotRange: Double = 1.1
    static func randomizeShape(channels: [NFChannelType:NFChannel]) -> [NFChannelType:NFChannel] {
        
        var randomChannels: [NFChannelType:NFChannel] = [:]
        
        for (channelType, channel) in channels {
            
            randomChannels[channelType] = NFChannel(channel: channel)
            
            if channelType == .positionX {
                randomChannels[channelType]!.vector = randomizeVector(vector: channel.vector)
            }
            
            if channelType == .positionY {
                randomChannels[channelType]!.vector = randomizeVector(vector: channel.vector)
            }
        }
        
        return randomChannels
    }
    
    static func randomizeVector(vector: NFChannelVector) -> NFChannelVector {
        
        var vect = vector
        vect.c0 = randomizeValue(value: vector.c0)
        vect.c1 = randomizeValue(value: vector.c1)
        return vect
    }
    
    static func randomizeValue(value: Double?) -> Double {
        
        var d = drand48() // between 0 and 1
        d   -= 0.5      // -0.5 + 0.5
        d   *= shapeRange
        return (value ?? 0) + d
    }
    
    static func randomizeValues(x: CGFloat, y: CGFloat) -> (x: CGFloat, y: CGFloat) {
        
        var d = drand48() // between 0 and 1
        d   -= 0.5      // -0.5 + 0.5
        d   *= dotRange
        
        let rx: CGFloat = x + CGFloat(d)
        
        d = drand48() // between 0 and 1
        d   -= 0.5      // -0.5 + 0.5
        d   *= dotRange
        
        let ry: CGFloat = y + CGFloat(d)
        
        return (x: rx, y: ry)
    }
}
