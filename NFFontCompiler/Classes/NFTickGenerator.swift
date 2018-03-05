//
//  NFTickGenerator.swift
//  NFLabel
//
//  Created by Piotr Bitner on 08/02/2018.
//

import Foundation

protocol NFTickGeneratorDelegate: class {
    func tick()
}

class NFTickGenerator {
    
    weak var delegate: NFTickGeneratorDelegate?
    
    
    var isPlaying = false
    var tickTime = 0.016
    
    func start() {
        isPlaying = true
        delegate?.tick()
        tick()
    }
    
    func pause() {
        isPlaying = !isPlaying
        tick()
    }
    
    func stop() {
        isPlaying = false
    }
    
    func tick() {
        
        if !isPlaying { return }
        
        DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + tickTime ) {
            self.delegate?.tick()
            self.tick()
        }
        
    }
}
