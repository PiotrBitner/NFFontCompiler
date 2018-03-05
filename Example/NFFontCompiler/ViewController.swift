//
//  ViewController.swift
//  NFFontCompiler
//
//  Created by ppbitner@gmail.com on 03/05/2018.
//  Copyright (c) 2018 ppbitner@gmail.com. All rights reserved.
//

import UIKit
import NFFontCompiler

class ViewController: UIViewController {
    
    @IBOutlet weak var labelView:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let fontJSON = simpletJSON
        
        var fontName: String = "Simplet"
        
        // compile
        let doCompile =  true
        let doRead = true
        
        if doCompile {
            if let fontData = NFFontCompiler.parse(nfjson: fontJSON ) {
                print("1 fontJSON parsed to font data")
                let font = NFFontCompiler.parse(data: fontData)
                print("2 font data parsed to font")
                fontName = fontData.overview.name
                
                let compiler = NFFontCompiler(font:font)
                compiler.compile()
                if let compiledFont = compiler.compliedFont {
                    print("3 font compiled")
                    let fontFile = NFCompiledFontFile(compiledFont: compiledFont)
                    // save
                    fontFile.save()
                    print("4 font saved")
                }
            }
        }
        
        
        // read
        if doRead {
            if let fontFromFile = NFCompiledFontFile.read(fontName: fontName) {
                print("\n font \(fontName) read")
            }
        }
    
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

