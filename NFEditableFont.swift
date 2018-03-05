//
//  NFEditableFont.swift
//  NFSign
//
//  Created by Piotr Bitner on 20/02/2018.
//

import Foundation


class NFEditableFont: NFFont{
    
    
    public var fontFeatures:[NFFontFeatures : CGFloat]  {
        
        get {
            var ff: [NFFontFeatures: CGFloat] = [:]
            ff[NFFontFeatures.quality] = CGFloat(fontData.features.quality)
            ff[NFFontFeatures.boldTipScale] = CGFloat(fontData.features.boldTipScale)
            ff[NFFontFeatures.italicAngle] = CGFloat(fontData.features.italicAngle)
           // ff[NFFontFeatures.italicHeight] = CGFloat(fontData.features.italicHeight)
            ff[NFFontFeatures.lightTipScale] = CGFloat(fontData.features.lightTipScale ?? 1.0)
            ff[NFFontFeatures.lightScale] = CGFloat(fontData.features.lightScale ?? 1.0)
            ff[NFFontFeatures.strongTipScale] = CGFloat(fontData.features.strongTipScale ?? 1.0)
            ff[NFFontFeatures.strongScale] = CGFloat(fontData.features.strongScale ?? 1.0)
            return ff
        }
        
        set {
            
            for (key, value) in newValue {
                switch key {
                    
                case .quality:
                    fontData.features.quality = Double(value)
                case .boldTipScale:
                    fontData.features.boldTipScale = Double(value)
                case .italicAngle:
                    fontData.features.italicAngle = Double(value)
               // case .italicHeight:
                  //  fontData.features.italicHeight = Double(value)
                case .lightTipScale:
                    fontData.features.lightTipScale = Double(value)
                case .lightScale:
                    fontData.features.lightScale = Double(value)
                case .strongTipScale:
                    fontData.features.strongTipScale = Double(value)
                case .strongScale:
                    fontData.features.strongScale = Double(value)
                default:
                    defaultCase()
                }
            }
        }
    }

    
}
