//
//  MusicPlayerViewModel.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 7/11/24.
//

import Foundation
import MediaPlayer

class MusicPlayerViewModel: ObservableObject {
    @Published var percentVolume: CGFloat = 1

    let audioType: AudioType
    private var volumeSlider: UISlider!

    public var audioVolume: Double {
        get {
            return Double(volumeSlider.value)
        }
        set {
            percentVolume = min(max(newValue, 0), 1)
            volumeSlider.value = Float(percentVolume)
            SoundManager.shared.adjustVolume(audioType: self.audioType, newVolume: Float(percentVolume))
        }
    }
    
    init(audioType: AudioType) {
        volumeSlider = UISlider()
        
        self.audioType = audioType
    }
}


enum AudioType: String {
    case sfx = "SFX"
    case bgm = "BGM"
}
