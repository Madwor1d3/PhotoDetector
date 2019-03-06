//
//  SoundModel.swift
//  PhotoDetector
//
//  Created by Madwor1d3 on 06/03/2019.
//  Copyright © 2019 Madwor1d3. All rights reserved.
//

import Foundation
import AVFoundation

struct SoundModel{
    
    private var audioPlayer: AVAudioPlayer!
    let soundArray = ["Meow", "Screech"]
    
    
    mutating func playSound(soundFileName: String) {
        
        let soundURL = Bundle.main.url(forResource: soundFileName, withExtension: "wav")
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL!)
        } catch {
            print(error)
        }
        audioPlayer.play()
    }
}
