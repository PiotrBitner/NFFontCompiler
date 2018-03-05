//
//  NFShape.swift
//  NFLabel
//
//  Created by Piotr Bitner on 09/02/2018.
//

/*
 
Used to create shape of nib or trajectory of nib in line.
 
 */

import Foundation

extension NFJoint{
    
    var title: String {
        switch self {
        case .open:
            return "Open"
        case .corner:
            return "Corner"
        case .smooth:
            return "Smooth"
        case .symetric:
            return "Symetric"
        }
    }
}



enum NFCurvePointKind: Int {
    
    case p0, p1, c0, c1
    
    func name() -> String {
        switch self {
        case .p0:
            return "p0"
        case .p1:
            return "p1"
        case .c0:
            return "c0"
        case .c1:
            return "c1"
        }
    }
    
}

extension NFChannel {
    
    func getChannelPoint(point: NFCurvePointKind) -> CGPoint {
        
        switch point {
        case .p0:
            return p0
        case .p1:
            return p1
        case .c0:
            return c0
        case .c1:
            return c1
        }
    }
    
    func setChannelPoint(value: CGPoint, point: NFCurvePointKind)  {
        switch point {
        case .p0:
            p0 = value
        case .p1:
            p1 = value
        case .c0:
            c0 = value
        case .c1:
            c1 = value
        }
    }
    
}

class NFCurveEditor {
    
    static func pointsFromLine(line: NFElement, channelType: NFChannelType) -> [NFCurvePoints]{
        if channelType == .shape {
            return pointsFromLine(line: line)
        } else {
            
            let channel = line.channels?[channelType]
            var points: NFCurvePoints = [:]
            
            points[.p0] = channel?.getChannelPoint(point: .p0)
            points[.p1] = channel?.getChannelPoint(point: .p1)
            points[.c0] = channel?.getChannelPoint(point: .c0)
            points[.c1] = channel?.getChannelPoint(point: .p1)
            
            return [points]
        }
    }
    
    static func pointsFromLine(line: NFElement) -> [NFCurvePoints] {
        
        return line.shapes.map({
            if $0.shapeChannel == nil {
                $0.shapeChannel = NFVirtualChannelXY(type: .shape, interpolation: .bezier, active: true)
            }
            
            $0.shapeChannel!.channelX = $0.xChannel
            $0.shapeChannel!.channelY = $0.yChannel
            
            var points: NFCurvePoints = [:]
            points[.p0] = $0.shapeChannel!.p0
            points[.p1] = $0.shapeChannel!.p1
            points[.c0] = $0.shapeChannel!.c0
            points[.c1] = $0.shapeChannel!.c1
            
            return points
        })
        
    }
}


typealias NFCurvePoints = [NFCurvePointKind: CGPoint]

class NFCurvePointsJoint {
    
    init(joint: NFJoint, curvePoints: NFCurvePoints) {
        self.joint = joint
        self.curvePoints = curvePoints
    }
    
    var joint: NFJoint
    var curvePoints: NFCurvePoints
}

extension NFShapeJoint: Equatable {
    static public func == (lhs: NFShapeJoint, rhs: NFShapeJoint) -> Bool {
        return (lhs.code == rhs.code)
    }
}
