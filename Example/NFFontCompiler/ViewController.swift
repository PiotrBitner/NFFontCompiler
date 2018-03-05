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
      
        /*
        let fontJSON = simpletJSON
        
        if let fontData = NFSigns.parse(nfjson: simpletJSON) {
            if fonts![fontName] == nil {
                let font = NFSigns.parse(data: fontData)
                if let compiledFont = compileFont(font: font) {
                    let factory = NFSignsFactory(compiledFont: compiledFont)
                    // let signs = NFSigns(font: font)
                    fonts![fontName] = factory
                }
            }
        }
       */
    }
    
    func saveRead(compiledFont: NFCompiledFont) -> NFCompiledFont{
        
        let fontFile = NFCompiledFontFile(compiledFont: compiledFont)
        
        fontFile.save()
        
        let fontFromFile = NFCompiledFontFile.read(fontName: "Aramejski")!
        
        let overview = fontFromFile.overview
        
        let name = overview?.name
        
        print(name!)
        
        return fontFromFile
    }
    
    func getFont(fontName: String) -> NFCompiledFont? {
        var compiledFont: NFCompiledFont?
        
        if let fontFromFile = NFCompiledFontFile.read(fontName: fontName) {
            compiledFont = fontFromFile
        } else {
            let sFactory = nfFontManager.addFont(fontName: "Aramejski")!
            let fontFile = NFCompiledFontFile(compiledFont: sFactory.compiledFont)
            fontFile.save()
            
            compiledFont = sFactory.compiledFont
        }
        
        return compiledFont
    }
    
    //protocol NFSignDelegate
    func done() {
        print("scribing done")
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

