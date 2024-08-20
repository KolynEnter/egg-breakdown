//
//  OptionsViewModel.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 8/19/24.
//

import Foundation
import AVFAudio

@Observable class OptionsViewModel {
    private var audioSystem: AudioSystem
    
    init() {
        audioSystem = AudioSystem()
    }
    
    func playSFX(sfxName: String, extension ext: String) -> Void {
        guard let soundURL = Bundle.main.url(forResource: sfxName, withExtension: ext) else {
            print("Sound file not found")
            return
        }
        
        do {
            audioSystem.sfxPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioSystem.sfxPlayer?.volume = audioSystem.sfxVolume
            audioSystem.sfxPlayer?.prepareToPlay()
            audioSystem.sfxPlayer?.play()
        } catch {
            print("Failed to load the sound: \(error)")
        }
    }
    
    func playBGM(bgmName: String, extension ext: String) -> Void {
        guard let soundURL = Bundle.main.url(forResource: bgmName, withExtension: ext) else {
            print("Sound file not found")
            return
        }
        
        do {
            audioSystem.bgmPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioSystem.bgmPlayer?.numberOfLoops = -1
            audioSystem.bgmPlayer?.prepareToPlay()
            audioSystem.bgmPlayer?.play()
        } catch {
            print("Failed to load the sound: \(error)")
        }
    }
    
    func adjustVolume(audioType: AudioType, newVolume: Float) -> Void {
        if audioType == .sfx {
            audioSystem.sfxVolume = newVolume
        } else if audioType == .bgm {
            audioSystem.bgmPlayer?.volume = newVolume
        }
    }
    
    static var mock: OptionsViewModel {
        let instance: OptionsViewModel = .init()
//        instance.playBGM(bgmName: "bgm_loop", extension: "mp3")
        return instance
    }
}
