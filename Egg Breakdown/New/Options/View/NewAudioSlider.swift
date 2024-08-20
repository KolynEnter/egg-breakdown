//
//  NewAudioSlider.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 8/19/24.
//

import SwiftUI

struct NewAudioSlider: View {
    @Environment(OptionsViewModel.self) var optionsViewModel: OptionsViewModel
    @State private var percentVolume: CGFloat = 1
    
    let audioType: AudioType
    
    var body: some View {
        GeometryReader { metrics in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(Color.black.opacity(0.08))
                    .frame(height: 8)
                Capsule()
                    .fill(Color.TextColorPrimary)
                    .frame(width: percentVolume * metrics.size.width, height: 8)
                Circle()
                    .fill(Color.TextColorPrimary)
                    .frame(width: 18, height: 18)
                    .padding(.leading, percentVolume * metrics.size.width - 9)
            }
            .gesture(DragGesture()
                .onChanged({ (value) in
                    let x = value.location.x
                    percentVolume = min(max(x / metrics.size.width, 0), 1)
                    optionsViewModel.adjustVolume(audioType: audioType, newVolume: Float(percentVolume))
                }).onEnded({ (value) in
                    let x = value.location.x
                    let percent = x / metrics.size.width
                    percentVolume = min(max(percent, 0), 1)
                    optionsViewModel.adjustVolume(audioType: audioType, newVolume: Float(percentVolume))
                }))
        }
        .frame(width: 100, height: 20)
    }
}

#Preview {
    NewAudioSlider(audioType: .bgm)
        .environment(OptionsViewModel.mock)
}
