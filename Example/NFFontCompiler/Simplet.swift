//
//  Simplet.swift
//  
//
//  Created by Piotr Bitner on 14/02/2018.
//

// ver. 1.0, 23/02/2018
import Foundation
import NFFontCompiler

// Add tips!
let simpletJSON: NFJSON = [
    
    "overview" : [
        "name" : "Simplet" as AnyObject,
        "fontKind" : "Natural Font" as AnyObject,
        "familyName" : "Simplet-Regular" as AnyObject,
        "author" : "Piotr Bitner" as AnyObject,
        "copyrights" : "Obrębalski Design" as AnyObject,
        ] as AnyObject,
    
    "features" : [
        "lineHeight" : 14.0 as AnyObject,
        "boldTipScale" : 1.3 as AnyObject,
        "lightTipScale" : 0.85 as AnyObject,
        "lightScale" : 1.2 as AnyObject,
        "strongTipScale" : 1.3 as AnyObject,
        "strongScale" : 0.95 as AnyObject,
        "italicAngle" : Double.pi / 24 as AnyObject,
        "hardRandom" : 1.1  as AnyObject,
        "lightRandom" : 0.2 as AnyObject,
        "quality" : 0.025 as AnyObject
        ] as AnyObject,
    
    "dimensions" : [
        "height" : 12.0 as AnyObject,
        "size" : 12.0 as AnyObject,
        "base" : 0.0 as AnyObject,
        "ascender" : 7.0 as AnyObject,
        "descender" : 3.0 as AnyObject,
        "capHeight" : 10.0 as AnyObject,
        "xHeight" : 5.0 as AnyObject,
        "gap" : 1.0 as AnyObject
        ] as AnyObject,
    
    
    // colors
    "colors" : [
        "primaryColor" : ["r" : 1.0, "g": 0.0 , "b": 0.0, "a" : 0.4] as AnyObject,
       // "primaryColorLight" : ["r" : 1.0, "g": 0.0 , "b": 0.0, "a" : 1.0] as AnyObject,
       // "primaryColorDark" : ["r" : 1.0, "g": 0.0 , "b": 0.0, "a" : 1.0] as AnyObject,
        "secondaryColor" : ["r" : 0.0, "g": 0.0 , "b": 1.0, "a" : 0.4] as AnyObject,
      //  "secondaryColorLight" : ["r" : 0.0, "g": 0.0 , "b": 1.0, "a" : 1.0] as AnyObject,
      //  "secondaryColorDark" : ["r" : 0.0, "g": 0.0 , "b": 1.0, "a" : 1.0] as AnyObject,
        ] as AnyObject,
    
    // libraries

    "characters" : [
        a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, v, u, w, x, y, z, sp,
        d0, d1, d2, d3, d4, d5, d6, d7, d8, d9,
        pDot, pComma, pExclamation, pQuestion, pDash, pUnderline,
        A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z
        ] as AnyObject,
    "nibs" : [] as AnyObject,
    "glyphs" : [
        ag, bg, cg, dg, eg, fg, gg, hg, ig, jg, kg, lg, mg, ng, og, pg, qg, rg, sg, tg, vg, ug, wg, xg, yg, zg, spg,
        d0g, d1g, d2g, d3g, d4g, d5g, d6g, d7g, d8g, d9g,
        pDotg, pCommag, pExclamationg, pQuestiong, pDashg, pUnderlineg,
        Ag, Bg, Cg, Dg, Eg, Fg, Gg, Hg, Ig, Jg, Kg, Lg, Mg, Ng, Og, Pg, Qg, Rg, Sg, Tg, Ug, Vg, Wg, Xg, Yg, Zg
        ] as AnyObject,
    "lines" : [
        dn2LeftLine, dn2RightLine, dnShortLine, dnLongLine, rightShortLine, dn2LeftLongLine, dn2RightLongLine,
        dn2RightExtraLongLine, dn2LeftExtraLongLine, dotLine, commaLine, underlineLine
        ] as AnyObject,

    // templates
   // "glyphTemplates" : [] as AnyObject,
   // "lineTemplates" : [] as AnyObject
]

//
// widths
//

let narrow = 1.2
let standard = 3.4
let wide = 4.0
let extra = 4.0

//
// capitals
//

let A: NFJSON = [
    "code" : 0x0041 as AnyObject,
    "name" : "V capital" as AnyObject,
    "width" :  extra  as AnyObject,
    "elements" : [0x0041] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let Ag: NFJSON = [
    "code" : 0x0041 as AnyObject,
    "elements" : [dnLongCode, dn2RightExtraLongCode, rightShortCode] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0], ["x": 0.0, "y": 0.0], ["x": 0.5, "y": -5.5] ] as AnyObject,
]


let B: NFJSON = [
    "code" : 0x0042 as AnyObject,
    "name" : "B capital" as AnyObject,
    "width" : wide  as AnyObject,
    "elements" : [0x0042] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let Bg: NFJSON = [
    "code" : 0x0042 as AnyObject,
    "elements" : [dnLongCode, dn2RightCode, dn2LeftCode, dn2RightCode, dn2LeftCode] as AnyObject,
    "origins" : [["x": 0.5, "y": 0.0], ["x": 0.0, "y": -8.0], ["x": 0.0, "y": -5.0], ["x": 0.0, "y": -2.8], ["x": 0.0, "y": 0.2]] as AnyObject,
]

let C: NFJSON = [
    "code" : 0x0043 as AnyObject,
    "name" : "C capital" as AnyObject,
    "width" : standard  as AnyObject,
    "elements" : [0x0043] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let Cg: NFJSON = [
    "code" : 0x0043 as AnyObject,
    "elements" : [dn2LeftLongCode, dn2RightLongCode] as AnyObject,
    "origins" : [["x": 0.0, "y": -5.0], ["x": 0.0, "y": 0.0]] as AnyObject,
]

let D: NFJSON = [
    "code" : 0x0044 as AnyObject,
    "name" : "C capital" as AnyObject,
    "width" : wide  as AnyObject,
    "elements" : [0x0044] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let Dg: NFJSON = [
    "code" : 0x0044 as AnyObject,
    "elements" : [dnLongCode, dn2RightLongCode, dn2LeftLongCode] as AnyObject,
    "origins" : [["x": 0.0, "y": -0.5], ["x": 0.5, "y": -5.0], ["x": 0.5, "y": 0.0]] as AnyObject,
]

let E: NFJSON = [
    "code" : 0x0045 as AnyObject,
    "name" : "E capital" as AnyObject,
    "width" : standard  as AnyObject,
    "elements" : [0x0045] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let Eg: NFJSON = [
    "code" : 0x0045 as AnyObject,
    "elements" : [dnLongCode, rightShortCode, rightShortCode, rightShortCode] as AnyObject,
    "origins" : [["x": 0.0, "y": -0.5], ["x": 0.5, "y": -11.0], ["x": 0.5, "y": -5.5], ["x": 0.5, "y": 0.0] ] as AnyObject,
]

let F: NFJSON = [
    "code" : 0x0046 as AnyObject,
    "name" : "F capital" as AnyObject,
    "width" : standard  as AnyObject,
    "elements" : [0x0046] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let Fg: NFJSON = [
    "code" : 0x0046 as AnyObject,
    "elements" : [dnLongCode, rightShortCode, rightShortCode] as AnyObject,
    "origins" : [["x": 0.0, "y": -0.5], ["x": 0.5, "y": -11.0], ["x": 0.5, "y": -5.5] ] as AnyObject,
]

let G: NFJSON = [
    "code" : 0x0047 as AnyObject,
    "name" : "G capital" as AnyObject,
    "width" : extra  as AnyObject,
    "elements" : [0x0047] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let Gg: NFJSON = [
    "code" : 0x0047 as AnyObject,
    "elements" : [dn2LeftLongCode, dn2RightLongCode, rightShortCode, dn2LeftLongCode] as AnyObject,
    "origins" : [["x": 0.0, "y": -5.0], ["x": 0.0, "y": 0.0], ["x": 2.5, "y": -5.5], ["x": 2.5, "y": 0.0]] as AnyObject,
]

let H: NFJSON = [
    "code" : 0x0048 as AnyObject,
    "name" : "H capital" as AnyObject,
    "width" : standard  as AnyObject,
    "elements" : [0x0048] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let Hg: NFJSON = [
    "code" : 0x0048 as AnyObject,
    "elements" : [dnLongCode, dnLongCode, rightShortCode] as AnyObject,
    "origins" : [["x": 0.0, "y": -0.5], ["x": 3.0, "y": -0.5], ["x": 0.5, "y": -5.5] ] as AnyObject,
]

let I: NFJSON = [
    "code" : 0x0049 as AnyObject,
    "name" : "I capital" as AnyObject,
    "width" : standard  as AnyObject,
    "elements" : [0x0049] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let Ig: NFJSON = [
    "code" : 0x0049 as AnyObject,
    "elements" : [dnLongCode, rightShortCode, rightShortCode] as AnyObject,
    "origins" : [["x": 1.0, "y": -0.5], ["x": 0.0, "y": -11.0], ["x": 0.0, "y": 0.0] ] as AnyObject,
]

let J: NFJSON = [
    "code" : 0x004A as AnyObject,
    "name" : "J capital" as AnyObject,
    "width" : standard  as AnyObject,
    "elements" : [0x004A] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let Jg: NFJSON = [
    "code" : 0x004A as AnyObject,
    "elements" : [dnLongCode, rightShortCode, rightShortCode] as AnyObject,
    "origins" : [["x": 2.0, "y": -0.5], ["x": 0.0, "y": -11.0], ["x": 0.0, "y": 0.0] ] as AnyObject,
]

let K: NFJSON = [
    "code" : 0x004B as AnyObject,
    "name" : "K capital" as AnyObject,
    "width" : standard  as AnyObject,
    "elements" : [0x004B] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let Kg: NFJSON = [
    "code" : 0x004B as AnyObject,
    "elements" : [dnLongCode, dn2LeftLongCode, dn2RightLongCode] as AnyObject,
    "origins" : [["x": 0.5, "y": -0.5], ["x": 0.0, "y": -5.0], ["x": 0.0, "y": 0.0]] as AnyObject,
]

let L: NFJSON = [
    "code" : 0x004C as AnyObject,
    "name" : "L capital" as AnyObject,
    "width" : wide  as AnyObject,
    "elements" : [0x004C] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let Lg: NFJSON = [
    "code" : 0x004C as AnyObject,
    "elements" : [dnLongCode, rightShortCode] as AnyObject,
    "origins" : [["x": 0.0, "y": -0.5], ["x": 0.5, "y": 0.0] ] as AnyObject,
]

let M: NFJSON = [
    "code" : 0x004D as AnyObject,
    "name" : "M capital" as AnyObject,
    "width" : extra + 1  as AnyObject,
    "elements" : [0x004D] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let Mg: NFJSON = [
    "code" : 0x004D as AnyObject,
    "elements" : [dnLongCode, dn2RightCode, dn2LeftCode, dnLongCode] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0], ["x": 0.25, "y": -7.0], ["x": 2.7, "y": -7.0], ["x": 5.8, "y": 0.0]] as AnyObject,
]

let N: NFJSON = [
    "code" : 0x004E as AnyObject,
    "name" : "N capital" as AnyObject,
    "width" : wide  as AnyObject,
    "elements" : [0x004E] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let Ng: NFJSON = [
    "code" : 0x004E as AnyObject,
    "elements" : [dnLongCode, dn2RightCode, dnLongCode] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0], ["x": 0.25, "y": -7.0], ["x": 3.2, "y": 0.0]] as AnyObject,
]

let O: NFJSON = [
    "code" : 0x004F as AnyObject,
    "name" : "O capital" as AnyObject,
    "width" : extra  as AnyObject,
    "elements" : [0x004F] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let Og: NFJSON = [
    "code" : 0x004F as AnyObject,
    "elements" : [dn2LeftLongCode, dn2RightLongCode, dn2RightLongCode, dn2LeftLongCode] as AnyObject,
    "origins" : [["x": 0.0, "y": -5.0], ["x": 0.0, "y": 0.0], ["x": 2.5, "y": -5.0], ["x": 2.5, "y": 0.0]] as AnyObject,
]

let P: NFJSON = [
    "code" : 0x0050 as AnyObject,
    "name" : "P capital" as AnyObject,
    "width" : standard  as AnyObject,
    "elements" : [0x0050] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let Pg: NFJSON = [
    "code" : 0x0050 as AnyObject,
    "elements" : [dnLongCode, dn2RightCode, dn2LeftCode] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0], ["x": 0.5, "y": -8.0], ["x": 0.5, "y": -5.0]] as AnyObject,
]

let Q: NFJSON = [
    "code" : 0x0051 as AnyObject,
    "name" : "Q capital" as AnyObject,
    "width" : extra  as AnyObject,
    "elements" : [0x0051] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let Qg: NFJSON = [
    "code" : 0x0051 as AnyObject,
    "elements" : [dn2LeftLongCode, dn2RightLongCode, dn2RightLongCode, dn2LeftLongCode, dn2RightCode] as AnyObject,
    "origins" : [["x": 0.0, "y": -5.0], ["x": 0.0, "y": 0.0], ["x": 2.5, "y": -5.0], ["x": 2.5, "y": 0.0], ["x": 2.5, "y": 0.0]] as AnyObject,
]


let R: NFJSON = [
    "code" : 0x0052 as AnyObject,
    "name" : "R capital" as AnyObject,
    "width" : wide  as AnyObject,
    "elements" : [0x0052] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let Rg: NFJSON = [
    "code" : 0x0052 as AnyObject,
    "elements" : [dnLongCode, dn2RightCode, dn2LeftCode, dn2RightLongCode] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0], ["x": 0.5, "y": -8.0], ["x": 0.5, "y": -5.0], ["x": 0.5, "y": 0.0]] as AnyObject,
]

let S: NFJSON = [
    "code" : 0x0053 as AnyObject,
    "name" : "S capital" as AnyObject,
    "width" : wide  as AnyObject,
    "elements" : [0x0053] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let Sg: NFJSON = [
    "code" : 0x0053 as AnyObject,
    "elements" : [dn2LeftLongCode, rightShortCode, dn2LeftLongCode] as AnyObject,
    "origins" : [["x": 0.0, "y": -5.0], ["x": 0.5, "y": -5.25], ["x": 0.0, "y": 0.5]] as AnyObject,
]

let T: NFJSON = [
    "code" : 0x0054 as AnyObject,
    "name" : "T capital" as AnyObject,
    "width" : standard  as AnyObject,
    "elements" : [0x0054] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let Tg: NFJSON = [
    "code" : 0x0054 as AnyObject,
    "elements" : [dnLongCode, rightShortCode, rightShortCode] as AnyObject,
    "origins" : [["x": 1.5, "y": 0.0], ["x": 0.0, "y": -11.0], ["x": 1.0, "y": -11.0] ] as AnyObject,
]

let U: NFJSON = [
    "code" : 0x0055 as AnyObject,
    "name" : "U capital" as AnyObject,
    "width" : standard  as AnyObject,
    "elements" : [0x0055] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let Ug: NFJSON = [
    "code" : 0x0055 as AnyObject,
    "elements" : [dnLongCode, dnLongCode, rightShortCode] as AnyObject,
    "origins" : [["x": 0.0, "y": -0.5], ["x": 3.0, "y": -0.5], ["x": 0.5, "y": 0.0] ] as AnyObject,
]

let V: NFJSON = [
    "code" : 0x0056 as AnyObject,
    "name" : "V capital" as AnyObject,
    "width" : wide  as AnyObject,
    "elements" : [0x0056] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let Vg: NFJSON = [
    "code" : 0x0056 as AnyObject,
    "elements" : [dnLongCode, dn2LeftExtraLongCode] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0], ["x": 0.0, "y": 0.0] ] as AnyObject,
]

let W: NFJSON = [
    "code" : 0x0057 as AnyObject,
    "name" : "W capital" as AnyObject,
    "width" : extra + 1  as AnyObject,
    "elements" : [0x0057] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let Wg: NFJSON = [
    "code" : 0x0057 as AnyObject,
    "elements" : [dnLongCode, dn2LeftCode, dn2RightCode, dnLongCode] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0], ["x": 0.25, "y": 0.0], ["x": 2.7, "y": 0.0], ["x": 5.8, "y": 0.0]] as AnyObject,
]

let X: NFJSON = [
    "code" : 0x0058 as AnyObject,
    "name" : "X capital" as AnyObject,
    "width" : extra  as AnyObject,
    "elements" : [0x0058] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let Xg: NFJSON = [
    "code" : 0x0058 as AnyObject,
    "elements" : [dn2RightExtraLongCode, dn2LeftExtraLongCode ] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0], ["x": 0.0, "y": 0.0]] as AnyObject,
]

let Y: NFJSON = [
    "code" : 0x0059 as AnyObject,
    "name" : "Y capital" as AnyObject,
    "width" : standard  as AnyObject,
    "elements" : [0x0059] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let Yg: NFJSON = [
    "code" : 0x0059 as AnyObject,
    "elements" : [dn2RightLongCode, dn2LeftExtraLongCode] as AnyObject,
    "origins" : [["x": 0.0, "y": -4.5], ["x": 0.5, "y": 0.0]] as AnyObject,
]


let Z: NFJSON = [
    "code" : 0x005A as AnyObject,
    "name" : "Z capital" as AnyObject,
    "width" : wide  as AnyObject,
    "elements" : [0x005A] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let Zg: NFJSON = [
    "code" : 0x005A as AnyObject,
    "elements" : [rightShortCode, dn2LeftExtraLongCode, rightShortCode] as AnyObject,
    "origins" : [["x": 2.55, "y": -10.0], ["x": 0.0, "y": 0.0], ["x": 0.5, "y": 0.0]] as AnyObject,
]


//
// punctuations
//

let pDash: NFJSON = [
    "code" : 0x002D as AnyObject,
    "name" : "dot" as AnyObject,
    "width" : narrow  as AnyObject,
    "elements" : [0x002D] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let pDashg: NFJSON = [
    "code" : 0x002D as AnyObject,
    "elements" : [rightShortCode] as AnyObject,
    "origins" : [["x": 0.0, "y": -4.8]] as AnyObject,
]

let pQuestion: NFJSON = [
    "code" : 0x003F as AnyObject,
    "name" : "dot" as AnyObject,
    "width" : standard  as AnyObject,
    "elements" : [0x003F] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let pQuestiong: NFJSON = [
    "code" : 0x003F as AnyObject,
    "elements" : [rightShortCode,  dn2LeftCode, dnShortCode, dotCode] as AnyObject,
    "origins" : [["x": 0.5, "y": -10.4], ["x": 0.25, "y": -7.6], ["x": 0.5, "y": -1.4], ["x": 0.25, "y": 0.0]] as AnyObject,
]

let pExclamation: NFJSON = [
    "code" : 0x0021 as AnyObject,
    "name" : "dot" as AnyObject,
    "width" : narrow  as AnyObject,
    "elements" : [0x0021] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let pExclamationg: NFJSON = [
    "code" : 0x0021 as AnyObject,
    "elements" : [dnLongCode, dotCode] as AnyObject,
    "origins" : [["x": 0.25, "y": -1.4], ["x": 0.0, "y": 0.0]] as AnyObject,
]

let pDot: NFJSON = [
    "code" : 0x002E as AnyObject,
    "name" : "dot" as AnyObject,
    "width" : narrow  as AnyObject,
    "elements" : [0x002E] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let pDotg: NFJSON = [
    "code" : 0x002E as AnyObject,
    "elements" : [dotCode] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject,
]

let pComma: NFJSON = [
    "code" : 0x002C as AnyObject,
    "name" : "comma" as AnyObject,
    "width" : narrow  as AnyObject,
    "elements" : [0x002C] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let pCommag: NFJSON = [
    "code" : 0x002C as AnyObject,
    "elements" : [commaCode] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject,
]

let pUnderline: NFJSON = [
    "code" : 0x005F as AnyObject,
    "name" : "comma" as AnyObject,
    "width" : wide  as AnyObject,
    "elements" : [0x005F] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let pUnderlineg: NFJSON = [
    "code" : 0x005F as AnyObject,
    "elements" : [underlineCode] as AnyObject,
    "origins" : [["x": 0.0, "y": 1.0]] as AnyObject,
]


//
// digits
//

let d1: NFJSON = [
    "code" : 0x0031 as AnyObject,
    "name" : "1" as AnyObject,
    "width" : standard  as AnyObject,
    "elements" : [0x0031] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let d1g: NFJSON = [
    "code" : 0x0031 as AnyObject,
    "elements" : [dn2LeftCode, dnLongCode] as AnyObject,
    "origins" : [["x": 0.0, "y": -6.2], ["x": 2.5, "y": 0.0]] as AnyObject,
]

let d2: NFJSON = [
    "code" : 0x0032 as AnyObject,
    "name" : "2" as AnyObject,
    "width" : standard  as AnyObject,
    "elements" : [0x0032] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let d2g: NFJSON = [
    "code" : 0x0032 as AnyObject,
    "elements" : [ dnShortCode, dnShortCode, rightShortCode, rightShortCode, rightShortCode] as AnyObject,
    "origins" : [ ["x": 0.0, "y": 0.0], ["x": 2.5, "y": -4.8], ["x": 0.5, "y": -9.8], ["x": 0.5, "y": -6.2], ["x": 0.5, "y": -0.2]] as AnyObject,
]

let d3: NFJSON = [
    "code" : 0x0033 as AnyObject,
    "name" : "3" as AnyObject,
    "width" : standard  as AnyObject,
    "elements" : [0x0033] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let d3g: NFJSON = [
    "code" : 0x0033 as AnyObject,
    "elements" : [dnLongCode, rightShortCode, rightShortCode, rightShortCode ] as AnyObject,
    "origins" : [ ["x": 2.5, "y": 0.0], ["x": 0.0, "y": -9.8], ["x": 0.0, "y": -6.2], ["x": 0.0, "y": -0.2]] as AnyObject,
]

let d4: NFJSON = [
    "code" : 0x0034 as AnyObject,
    "name" : "4" as AnyObject,
    "width" : standard  as AnyObject,
    "elements" : [0x0034] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let d4g: NFJSON = [
    "code" : 0x0034 as AnyObject,
    "elements" : [dn2LeftCode, rightShortCode, dnLongCode] as AnyObject,
    "origins" : [["x": 0.0, "y": -6.0], ["x": 0.5, "y": -6.2], ["x": 3.0, "y": 0.0]] as AnyObject,
]

let d5: NFJSON = [
    "code" : 0x0035 as AnyObject,
    "name" : "5" as AnyObject,
    "width" : standard  as AnyObject,
    "elements" : [0x0035] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let d5g: NFJSON = [
    "code" : 0x0035 as AnyObject,
    "elements" : [dnShortCode, rightShortCode, dnShortCode, rightShortCode, rightShortCode] as AnyObject,
    "origins" : [["x": 0.5, "y": -4.8], ["x": 0.5, "y": -5.8], ["x": 2.5, "y": 0.0], ["x": 0.5, "y": -9.8], ["x": 0.5, "y": -0.2]] as AnyObject,
]

let d6: NFJSON = [
    "code" : 0x0036 as AnyObject,
    "name" : "6" as AnyObject,
    "width" : standard  as AnyObject,
    "elements" : [0x0036] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let d6g: NFJSON = [
    "code" : 0x0036 as AnyObject,
    "elements" : [dnLongCode, rightShortCode, dnShortCode, rightShortCode] as AnyObject,
    "origins" : [["x": 0.0, "y": -0.2], ["x": 0.5, "y": -6.2], ["x": 2.5, "y": 0.0], ["x": 0.5, "y": -0.2]] as AnyObject,
]

let d7: NFJSON = [
    "code" : 0x0037 as AnyObject,
    "name" : "7" as AnyObject,
    "width" : standard  as AnyObject,
    "elements" : [0x0037] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let d7g: NFJSON = [
    "code" : 0x0037 as AnyObject,
    "elements" : [rightShortCode, dnLongCode ] as AnyObject,
    "origins" : [["x": 0.0, "y": -9.8], ["x": 2.5, "y": 0.0]] as AnyObject,
]

let d8: NFJSON = [
    "code" : 0x0038 as AnyObject,
    "name" : "8" as AnyObject,
    "width" : standard  as AnyObject,
    "elements" : [0x0038] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let d8g: NFJSON = [
    "code" : 0x0038 as AnyObject,
    "elements" : [dnLongCode, dnLongCode, rightShortCode, rightShortCode, rightShortCode ] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0], ["x": 2.5, "y": 0.0], ["x": 0.0, "y": -9.8], ["x": 0.0, "y": -6.2], ["x": 0.0, "y": -0.2]] as AnyObject,
]

let d9: NFJSON = [
    "code" : 0x0039 as AnyObject,
    "name" : "9" as AnyObject,
    "width" : standard  as AnyObject,
    "elements" : [0x0039] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let d9g: NFJSON = [
    "code" : 0x0039 as AnyObject,
    "elements" : [dnShortCode, dnLongCode, rightShortCode, rightShortCode] as AnyObject,
    "origins" : [["x": 0.0, "y": -4.8], ["x": 2.5, "y": 0.0], ["x": 0.5, "y": -9.8], ["x": 0.5, "y": -6.2]] as AnyObject,
]

let d0: NFJSON = [
    "code" : 0x0030 as AnyObject,
    "name" : "0" as AnyObject,
    "width" : standard  as AnyObject,
    "elements" : [0x0030] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let d0g: NFJSON = [
    "code" : 0x0030 as AnyObject,
    "elements" : [dnLongCode, dnLongCode, rightShortCode, rightShortCode ] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0], ["x": 2.5, "y": 0.0], ["x": 0.0, "y": -9.8], ["x": 0.0, "y": -0.2]] as AnyObject,
]



//
// letters
//

let a: NFJSON = [
    "code" : 0x0061 as AnyObject,
    "name" : "a lowercase" as AnyObject,
    "width" : standard  as AnyObject,
    "elements" : [0x0061] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let ag: NFJSON = [
    "code" : 0x0061 as AnyObject,
    "elements" : [dn2LeftCode, dn2RightCode, dnShortCode] as AnyObject,
    "origins" : [["x": 0.0, "y": -2.8], ["x": 0.0, "y": -0.2], ["x": 2.6, "y": 0.0]] as AnyObject,
]

let b: NFJSON = [
    "code" : 0x0062 as AnyObject,
    "name" : "b lowercase" as AnyObject,
    "width" : standard  as AnyObject,
    "elements" : [0x0062] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let bg: NFJSON = [
    "code" : 0x0062 as AnyObject,
    "elements" : [dnLongCode, dn2RightCode, dn2LeftCode] as AnyObject,
    "origins" : [["x": 0.5, "y": 0.0], ["x": 0.0, "y": -2.8], ["x": 0.0, "y": -0.2]] as AnyObject,
]

let c: NFJSON = [
    "code" : 0x0063 as AnyObject,
    "name" : "c lowercase" as AnyObject,
    "width" : standard  as AnyObject,
    "elements" : [0x0063] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let cg: NFJSON = [
    "code" : 0x0063 as AnyObject,
    "elements" : [dn2LeftCode, dn2RightCode] as AnyObject,
    "origins" : [["x": 0.0, "y": -2.8], ["x": 0.0, "y": -0.2]] as AnyObject,
]

let d: NFJSON = [
    "code" : 0x0064 as AnyObject,
    "name" : "d lowercase" as AnyObject,
    "width" : standard  as AnyObject,
    "elements" : [0x0064] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let dg: NFJSON = [
    "code" : 0x0064 as AnyObject,
    "elements" : [dn2LeftCode, dn2RightCode, dnLongCode] as AnyObject,
    "origins" : [["x": 0.0, "y": -2.8], ["x": 0.0, "y": -0.2], ["x": 2.5, "y": 0.0]] as AnyObject,
]

let e: NFJSON = [
    "code" : 0x0065 as AnyObject,
    "name" : "e lowercase" as AnyObject,
    "width" : wide  as AnyObject,
    "elements" : [0x0065] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let eg: NFJSON = [
    "code" : 0x0065 as AnyObject,
    "elements" : [dn2LeftCode, dn2RightCode, rightShortCode] as AnyObject,
    "origins" : [["x": 0.0, "y": -2.8], ["x": 0.0, "y": -0.2], ["x": 1.0, "y": -3.0]] as AnyObject,
]

let f: NFJSON = [
    "code" : 0x0066 as AnyObject,
    "name" : "f lowercase" as AnyObject,
    "width" : standard  as AnyObject,
    "elements" : [0x0066] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let fg: NFJSON = [
    "code" : 0x0066 as AnyObject,
    "elements" : [dnLongCode, dn2LeftCode] as AnyObject,
    "origins" : [["x": 1.5, "y": 0.0], ["x": 0.0, "y": -3.0]] as AnyObject,
]

let g: NFJSON = [
    "code" : 0x0067 as AnyObject,
    "name" : "g lowercase" as AnyObject,
    "width" : standard  as AnyObject,
    "elements" : [0x0067] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let gg: NFJSON = [
    "code" : 0x0067 as AnyObject,
    "elements" : [dn2LeftCode, dn2RightCode, dnLongCode] as AnyObject,
    "origins" : [["x": 0.0, "y": -2.8], ["x": 0.0, "y": -0.2], ["x": 2.5, "y": 4.0]] as AnyObject,
]

let h: NFJSON = [
    "code" : 0x0068 as AnyObject,
    "name" : "h lowercase" as AnyObject,
    "width" : standard  as AnyObject,
    "elements" : [0x0068] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let hg: NFJSON = [
    "code" : 0x0068 as AnyObject,
    "elements" : [dnLongCode, rightShortCode, dnShortCode] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0], ["x": 0.5, "y": -5.8], ["x": 2.5, "y": 0.0]] as AnyObject,
]

let i: NFJSON = [
    "code" : 0x0069 as AnyObject,
    "name" : "i lowercase" as AnyObject,
    "width" : narrow  as AnyObject,
    "elements" : [0x0069] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let ig: NFJSON = [
    "code" : 0x0069 as AnyObject,
    "elements" : [dnShortCode] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject,
]

let j: NFJSON = [
    "code" : 0x006A as AnyObject,
    "name" : "j lowercase" as AnyObject,
    "width" : narrow  as AnyObject,
    "elements" : [0x006A] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let jg: NFJSON = [
    "code" : 0x006A as AnyObject,
    "elements" : [dnLongCode] as AnyObject,
    "origins" : [["x": 0.0, "y": 4.0]] as AnyObject,
]

let k: NFJSON = [
    "code" : 0x006B as AnyObject,
    "name" : "k lowercase" as AnyObject,
    "width" : standard  as AnyObject,
    "elements" : [0x006B] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let kg: NFJSON = [
    "code" : 0x006B as AnyObject,
    "elements" : [dnLongCode, dn2LeftCode, dn2RightCode] as AnyObject,
    "origins" : [ ["x": 0.5, "y": 0.0], ["x": 0.0, "y": -2.8], ["x": 0.0, "y": -0.2]] as AnyObject,
]

let l: NFJSON = [
    "code" : 0x006C as AnyObject,
    "name" : "l lowercase" as AnyObject,
    "width" : standard as AnyObject,
    "elements" : [0x006C] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let lg: NFJSON = [
    "code" : 0x006C as AnyObject,
    "elements" : [dnLongCode, rightShortCode] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0], ["x": 0.5, "y": -0.2]] as AnyObject,
]

let m: NFJSON = [
    "code" : 0x006D as AnyObject,
    "name" : "m lowercase" as AnyObject,
    "width" : extra  as AnyObject,
    "elements" : [0x006D] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let mg: NFJSON = [
    "code" : 0x006D as AnyObject,
    "elements" : [dnShortCode, dn2RightCode, dn2LeftCode, dnShortCode] as AnyObject,
    "origins" : [["x": 0.25, "y": 0.0], ["x": 0.0, "y": -2.5], ["x": 2.45, "y": -2.5], ["x": 5.15, "y": 0.0]] as AnyObject,
]

let n: NFJSON = [
    "code" : 0x006E as AnyObject,
    "name" : "n lowercase" as AnyObject,
    "width" : standard  as AnyObject,
    "elements" : [0x006E] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let ng: NFJSON = [
    "code" : 0x006E as AnyObject,
    "elements" : [dnShortCode, dn2RightCode, dnShortCode] as AnyObject,
    "origins" : [["x": 0.25, "y": 0.0], ["x": 0.0, "y": -2.8], ["x": 2.8, "y": 0.0]] as AnyObject,
]

let o: NFJSON = [
    "code" : 0x006F as AnyObject,
    "name" : "o lowercase" as AnyObject,
    "width" : extra  as AnyObject,
    "elements" : [0x006F] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let og: NFJSON = [
    "code" : 0x006F as AnyObject,
    "elements" : [dn2LeftCode, dn2RightCode, dn2RightCode, dn2LeftCode] as AnyObject,
    "origins" : [["x": 0.0, "y": -2.8], ["x": 0.0, "y": -0.2], ["x": 2.0, "y": -2.8], ["x": 2.0, "y": -0.2]] as AnyObject,
]

let p: NFJSON = [
    "code" : 0x0070 as AnyObject,
    "name" : "p lowercase" as AnyObject,
    "width" : standard  as AnyObject,
    "elements" : [0x0070] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let pg: NFJSON = [
    "code" : 0x0070 as AnyObject,
    "elements" : [dnLongCode, dn2RightCode, dn2LeftCode] as AnyObject,
    "origins" : [["x": 0.5, "y": 4.0], ["x": 0.0, "y": -2.8], ["x": 0.0, "y": -0.2]] as AnyObject,
]

let q: NFJSON = [
    "code" : 0x0071 as AnyObject,
    "name" : "q lowercase" as AnyObject,
    "width" : standard  as AnyObject,
    "elements" : [0x0071] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let qg: NFJSON = [
    "code" : 0x0071 as AnyObject,
    "elements" : [ dn2LeftCode, dn2RightCode, dnLongCode, rightShortCode] as AnyObject,
    "origins" : [["x": 0.0, "y": -2.8], ["x": 0.0, "y": -0.2], ["x": 2.8, "y": 4.0], ["x": 2.5, "y": 4.0]] as AnyObject,
]

let r: NFJSON = [
    "code" : 0x0072 as AnyObject,
    "name" : "r lowercase" as AnyObject,
    "width" : standard  as AnyObject,
    "elements" : [0x0072] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let rg: NFJSON = [
    "code" : 0x0072 as AnyObject,
    "elements" : [dnShortCode, dn2LeftCode] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0], ["x": -0.5, "y": -2.8]] as AnyObject,
]

let s: NFJSON = [
    "code" : 0x0073 as AnyObject,
    "name" : "s lowercase" as AnyObject,
    "width" : standard  as AnyObject,
    "elements" : [0x0073] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let sg: NFJSON = [
    "code" : 0x0073 as AnyObject,
    "elements" : [dn2LeftCode, dn2RightCode, dn2LeftCode] as AnyObject,
    "origins" : [["x": 0.0, "y": -4.5], ["x": 0.0, "y": -2.0], ["x": 0.0, "y": 0.5]] as AnyObject,
]

let t: NFJSON = [
    "code" : 0x0074 as AnyObject,
    "name" : "t lowercase" as AnyObject,
    "width" : narrow  as AnyObject,
    "elements" : [0x0074] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let tg: NFJSON = [
    "code" : 0x0074 as AnyObject,
    "elements" : [dnLongCode, rightShortCode, rightShortCode] as AnyObject,
    "origins" : [["x": 1.0, "y": 0.0], ["x": 1.0, "y": 0.0], ["x": 0.0, "y": -6.0]] as AnyObject,
]

let u: NFJSON = [
    "code" : 0x0075 as AnyObject,
    "name" : "u lowercase" as AnyObject,
    "width" : standard  as AnyObject,
    "elements" : [0x0075] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let ug: NFJSON = [
    "code" : 0x0075 as AnyObject,
    "elements" : [dnShortCode, dn2LeftCode, dnShortCode] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0], ["x": -0.2, "y": -0.4], ["x": 2.5, "y": 0.0]] as AnyObject,
]

let v: NFJSON = [
    "code" : 0x0076 as AnyObject,
    "name" : "v lowercase" as AnyObject,
    "width" : wide  as AnyObject,
    "elements" : [0x0076] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let vg: NFJSON = [
    "code" : 0x0076 as AnyObject,
    "elements" : [dnShortCode, dn2LeftLongCode ] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0], ["x": 0.25, "y": 0.0]] as AnyObject,
]

let w: NFJSON = [
    "code" : 0x0077 as AnyObject,
    "name" : "w lowercase" as AnyObject,
    "width" : extra as AnyObject,
    "elements" : [0x0077] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let wg: NFJSON = [
    "code" : 0x0077 as AnyObject,
    "elements" : [dnShortCode, dn2LeftCode, dn2RightCode, dnShortCode] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0], ["x": -0.25, "y": -0.6], ["x": 2.2, "y": -0.6], ["x": 4.9, "y": 0.0]] as AnyObject,
]

let x: NFJSON = [
    "code" : 0x0078 as AnyObject,
    "name" : "x lowercase" as AnyObject,
    "width" : wide  as AnyObject,
    "elements" : [0x0078] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let xg: NFJSON = [
    "code" : 0x0078 as AnyObject,
    "elements" : [dn2RightLongCode, dn2LeftLongCode ] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0], ["x": 0.0, "y": 0.0]] as AnyObject,
]

let y: NFJSON = [
    "code" : 0x0079 as AnyObject,
    "name" : "y lowercase" as AnyObject,
    "width" : standard  as AnyObject,
    "elements" : [0x0079] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let yg: NFJSON = [
    "code" : 0x0079 as AnyObject,
    "elements" : [dn2RightLongCode, dnLongCode] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0], ["x": 2.5, "y": 4.0]] as AnyObject,
]

let z: NFJSON = [
    "code" : 0x007A as AnyObject,
    "name" : "z lowercase" as AnyObject,
    "width" : standard  as AnyObject,
    "elements" : [0x007A] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let zg: NFJSON = [
    "code" : 0x007A as AnyObject,
    "elements" : [rightShortCode, dn2LeftLongCode, rightShortCode] as AnyObject,
    "origins" : [["x": 1.5, "y": -6.0], ["x": 0.25, "y": 0.0], ["x": 0.0, "y": 0.0]] as AnyObject,
]

let sp: NFJSON = [
    "code" : 0x0020 as AnyObject,
    "name" : "space" as AnyObject,
    "width" : standard  as AnyObject,
    "elements" : [0x0020] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject
]

let spg: NFJSON = [
    "code" : 0x0020 as AnyObject,
    "elements" : [rightShortCode] as AnyObject,
    "origins" : [["x": 0.0, "y": 0.0]] as AnyObject,
]

//
// lines
//

let dn2LeftCode = 0x1001
let dn2RightCode = 0x1002
let dnShortCode = 0x1003
let dnLongCode = 0x1004
let rightShortCode = 0x1005
let dn2LeftLongCode = 0x1006
let dn2RightLongCode = 0x1007
let dn2LeftExtraLongCode = 0x1008
let dn2RightExtraLongCode = 0x1009
let dotCode = 0x100A
let commaCode = 0x100B
let underlineCode = 0x100C

let underlineLine: NFJSON = [
    "code" : underlineCode as AnyObject,
    "channels" : [channelSQ, positionZ, rotationZ, colors] as AnyObject,
    "shapes" : [underlineShape] as AnyObject,
    "images" : []  as AnyObject
]

let underlineShape: NFJSON = [
    "code" : underlineCode as AnyObject,
    "interpolation" : NFInterpolation.bezier.rawValue as AnyObject,
    "vectorX" : ["v0": 0.0, "v1": 3.0, "c0": 0.0, "c1": 3.0] as AnyObject,
    "vectorY" : ["v0": -0.5, "v1": -0.5, "c0": -0.5, "c1": -0.5] as AnyObject,
]


let commaLine: NFJSON = [
    "code" : commaCode as AnyObject,
    "channels" : [channelSQ, positionZ, rotationZ, colors] as AnyObject,
    "shapes" : [commaShape] as AnyObject,
    "images" : []  as AnyObject
]

let commaShape: NFJSON = [
    "code" : commaCode as AnyObject,
    "interpolation" : NFInterpolation.bezier.rawValue as AnyObject,
    "vectorX" : ["v0": 0.5, "v1": 0.0, "c0": 0.5, "c1": 0.0] as AnyObject,
    "vectorY" : ["v0": 0.0, "v1": -1.0, "c0": 0.0, "c1": -1.0] as AnyObject,
]

let dotLine: NFJSON = [
    "code" : dotCode as AnyObject,
    "channels" : [channelSQ, positionZ, rotationZ, colors] as AnyObject,
    "shapes" : [dotShape] as AnyObject,
    "images" : []  as AnyObject
]

let dotShape: NFJSON = [
    "code" : dotCode as AnyObject,
    "interpolation" : NFInterpolation.bezier.rawValue as AnyObject,
    "vectorX" : ["v0": 0.0, "v1": 0.5, "c0": 0.0, "c1": 0.5] as AnyObject,
    "vectorY" : ["v0": 0.0, "v1": 0.0, "c0": 0.0, "c1": 0.0] as AnyObject,
]

let dn2LeftLine: NFJSON = [
    "code" : dn2LeftCode as AnyObject,
    "channels" : [channelSQ, positionZ, rotationZ, colors] as AnyObject,
    "shapes" : [dn2LeftShape] as AnyObject,
    "images" : []  as AnyObject,
  //  "vertical" : true as AnyObject
    
]

let dn2LeftShape: NFJSON = [
    "code" : dn2LeftCode as AnyObject,
    "interpolation" : NFInterpolation.bezier.rawValue as AnyObject,
    "vectorX" : ["v0": 3.0, "v1": 0.0, "c0": 3.0, "c1": 0.0] as AnyObject,
    "vectorY" : ["v0": 3.0, "v1": 0.0, "c0": 3.0, "c1": 0.0] as AnyObject,
]

let dn2LeftLongLine: NFJSON = [
    "code" : dn2LeftLongCode as AnyObject,
    "channels" : [channelSQ, positionZ, rotationZ, colors] as AnyObject,
    "shapes" : [dn2LeftLongShape] as AnyObject,
    "images" : []  as AnyObject,
    "vertical" : true as AnyObject
]

let dn2LeftLongShape: NFJSON = [
    "code" : dn2LeftLongCode as AnyObject,
    "interpolation" : NFInterpolation.bezier.rawValue as AnyObject,
    "vectorX" : ["v0": 3.0, "v1": 0.0, "c0": 3.0, "c1": 0.0] as AnyObject,
    "vectorY" : ["v0": 6.0, "v1": 0.0, "c0": 6.0, "c1": 0.0] as AnyObject,
]

let dn2RightLine: NFJSON = [
    "code" : dn2RightCode as AnyObject,
    "channels" : [channelSQ, positionZ, rotationZ, colors] as AnyObject,
    "shapes" : [dn2RightShape] as AnyObject,
    "images" : []  as AnyObject,
   // "vertical" : true as AnyObject
]

let dn2RightShape: NFJSON = [
    "code" : dn2RightCode as AnyObject,
    "interpolation" : NFInterpolation.bezier.rawValue as AnyObject,
    "vectorX" : ["v0": 0.0, "v1": 3.0, "c0": 0.0, "c1": 3.0] as AnyObject,
    "vectorY" : ["v0": 3.0, "v1": 0.0, "c0": 3.0, "c1": 0.0] as AnyObject,
]

let dn2RightLongLine: NFJSON = [
    "code" : dn2RightLongCode as AnyObject,
    "channels" : [channelSQ, positionZ, rotationZ, colors] as AnyObject,
    "shapes" : [dn2RightLongShape] as AnyObject,
    "images" : []  as AnyObject,
    "vertical" : true as AnyObject
]

let dn2RightLongShape: NFJSON = [
    "code" : dn2RightLongCode as AnyObject,
    "interpolation" : NFInterpolation.bezier.rawValue as AnyObject,
    "vectorX" : ["v0": 0.0, "v1": 3.0, "c0": 0.0, "c1": 3.0] as AnyObject,
    "vectorY" : ["v0": 6.0, "v1": 0.0, "c0": 6.0, "c1": 0.0] as AnyObject,
]

let dnShortLine: NFJSON = [
    "code" : dnShortCode as AnyObject,
    "name" : "dnShortLine" as AnyObject,
    "channels" : [channelSQ, positionZ, rotationZ, colors] as AnyObject,
    "shapes" : [dnShortShape] as AnyObject,
    "images" : []  as AnyObject,
    "vertical" : true as AnyObject
]

let dnShortShape: NFJSON = [
    "code" : dnShortCode as AnyObject,
    "interpolation" : NFInterpolation.bezier.rawValue as AnyObject,
    "vectorX" : ["v0": 0.0, "v1": 0.0, "c0": 0.0, "c1": 0.0] as AnyObject,
    "vectorY" : ["v0": 6.0, "v1": 0.0, "c0": 6.0, "c1": 0.0] as AnyObject,
]

let dnLongLine: NFJSON = [
    "code" : dnLongCode as AnyObject,
    "name" : "dnLongLine" as AnyObject,
    "channels" : [channelSQ, positionZ, rotationZ, colors] as AnyObject,
    "shapes" : [dnLongShape] as AnyObject,
    "images" : []  as AnyObject,
    "vertical" : true as AnyObject
]

let dnLongShape: NFJSON = [
    "code" : dnLongCode as AnyObject,
    "interpolation" : NFInterpolation.bezier.rawValue as AnyObject,
    "vectorX" : ["v0": 0.0, "v1": 0.0, "c0": 0.0, "c1": 0.0] as AnyObject,
    "vectorY" : ["v0": 10.0, "v1": 0.0, "c0": 10.0, "c1": 0.0] as AnyObject,
]

let rightShortLine: NFJSON = [
    "code" : rightShortCode as AnyObject,
    "name" : "rightShortLine" as AnyObject,
    "channels" : [channelSQ, positionZ, rotationZ, colors] as AnyObject,
    "shapes" : [rightShortShape] as AnyObject,
    "images" : []  as AnyObject,
    "vertical" : false as AnyObject
]

let rightShortShape: NFJSON = [
    "code" : rightShortCode as AnyObject,
    "interpolation" : NFInterpolation.bezier.rawValue as AnyObject,
    "vectorX" : ["v0": 0.0, "v1": 2.0, "c0": 0.0, "c1": 2.0] as AnyObject,
    "vectorY" : ["v0": 0.0, "v1": 0.0, "c0": 0.0, "c1": 0.0] as AnyObject,
]

let dn2LeftExtraLongLine: NFJSON = [
    "code" : dn2LeftExtraLongCode as AnyObject,
    "channels" : [channelSQ, positionZ, rotationZ, colors] as AnyObject,
    "shapes" : [dn2LeftExtraLongShape] as AnyObject,
    "images" : []  as AnyObject,
    "vertical" : true as AnyObject
]

let dn2LeftExtraLongShape: NFJSON = [
    "code" : dn2LeftExtraLongCode as AnyObject,
    "interpolation" : NFInterpolation.bezier.rawValue as AnyObject,
    "vectorX" : ["v0": 5.0, "v1": 0.0, "c0": 5.0, "c1": 0.0] as AnyObject,
    "vectorY" : ["v0": 10.0, "v1": 0.0, "c0": 10.0, "c1": 0.0] as AnyObject,
]

let dn2RightExtraLongLine: NFJSON = [
    "code" : dn2RightExtraLongCode as AnyObject,
    "channels" : [channelSQ, positionZ, rotationZ, colors] as AnyObject,
    "shapes" : [dn2RightExtraLongShape] as AnyObject,
    "images" : []  as AnyObject,
    "vertical" : true as AnyObject
]

let dn2RightExtraLongShape: NFJSON = [
    "code" : dn2RightExtraLongCode as AnyObject,
    "interpolation" : NFInterpolation.bezier.rawValue as AnyObject,
    "vectorX" : ["v0": 0.0, "v1": 5.0, "c0": 0.0, "c1": 5.0] as AnyObject,
    "vectorY" : ["v0": 10.0, "v1": 0.0, "c0": 10.0, "c1": 0.0] as AnyObject,
]


//
// Channels
//

// remove active and locked from spec
// check half vector
let channelSQ: NFJSON = [
    // "active" : true as AnyObject,
    // "locked" : true as AnyObject,
    "type" : NFChannelType.SQ.rawValue as AnyObject,
    "interpolation" : NFInterpolation.constant.rawValue as AnyObject,
    "vector" : ["v0": 1.0, "v1": 0.0, "c0": 0.0, "c1": 0.0] as AnyObject
]

// check not using active and locked
let alpha: NFJSON = [
    "type" : NFChannelType.alpha.rawValue as AnyObject,
    "interpolation" : NFInterpolation.constant.rawValue as AnyObject,
    "vector" : ["v0": 0.7, "v1": 0.7, "c0": 0.7, "c1": 0.7] as AnyObject
]

let colors: NFJSON = [
    "type" : NFChannelType.colors.rawValue as AnyObject,
    "interpolation" : NFInterpolation.linear.rawValue as AnyObject,
    "vector" : ["v0": 0.0, "v1": 1.0, "c0": 0.0, "c1": 1.0] as AnyObject
]

let positionZ: NFJSON = [
    "type" : NFChannelType.positionZ.rawValue as AnyObject,
    "interpolation" : NFInterpolation.constant.rawValue as AnyObject,
    "vector" : ["v0": 1.0, "v1": 1.0, "c0": 1.0, "c1": 1.0] as AnyObject
]

let rotationX: NFJSON = [
    "type" : NFChannelType.rotationX.rawValue as AnyObject,
    "interpolation" : NFInterpolation.constant.rawValue as AnyObject,
    "vector" : ["v0": 0.5, "v1": 2.0, "c0": 0.0, "c1": 1.0] as AnyObject
]

let rotationY: NFJSON = [
    "type" : NFChannelType.rotationY.rawValue as AnyObject,
    "interpolation" : NFInterpolation.constant.rawValue as AnyObject,
    "vector" : ["v0": 1.0, "v1": 1.0, "c0": 1.0, "c1": 1.0] as AnyObject
]

let rotationZ: NFJSON = [
    "type" : NFChannelType.rotationZ.rawValue as AnyObject,
    "interpolation" : NFInterpolation.constant.rawValue as AnyObject,
    "vector" : ["v0": 0.0, "v1": 0.0, "c0": 0.0, "c1": 0.0] as AnyObject
]
