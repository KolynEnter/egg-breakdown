//
//  SoundManager.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 7/6/24.
//

import AVFoundation

class SoundManager {
    static let shared = SoundManager() // Singleton instance
    
    private var sfxPlayer: AVAudioPlayer?
    private var bgmPlayer: AVAudioPlayer?

    private init() {
        // Private initializer to enforce singleton pattern
    }
    
    func playSFX(sfxName: String, extension ext: String) {
        guard let soundURL = Bundle.main.url(forResource: sfxName, withExtension: ext) else {
            print("Sound file not found")
            return
        }
        
        do {
            sfxPlayer = try AVAudioPlayer(contentsOf: soundURL)
            sfxPlayer?.prepareToPlay()
            sfxPlayer?.play()
        } catch {
            print("Failed to load the sound: \(error)")
        }
    }
    
    func playBGM(bgmName: String, extension ext: String) {
        guard let soundURL = Bundle.main.url(forResource: bgmName, withExtension: ext) else {
            print("Sound file not found")
            return
        }
        
        do {
            bgmPlayer = try AVAudioPlayer(contentsOf: soundURL)
            bgmPlayer?.numberOfLoops = -1
            bgmPlayer?.prepareToPlay()
            bgmPlayer?.play()
        } catch {
            print("Failed to load the sound: \(error)")
        }
    }
}
