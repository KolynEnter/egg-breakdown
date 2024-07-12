//
//  AudioSlider.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 7/11/24.
//

import SwiftUI

struct AudioSlider: View {
    @ObservedObject var musicPlayer: MusicPlayerViewModel
    
    var body: some View {
        GeometryReader { metrics in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(Color.black.opacity(0.08))
                    .frame(height: 8)
                Capsule()
                    .fill(Color.red)
                    .frame(width: musicPlayer.percentVolume * metrics.size.width, height: 8)
                Circle()
                    .fill(Color.red)
                    .frame(width: 18, height: 18)
                    .padding(.leading, musicPlayer.percentVolume * metrics.size.width - 9)
            }
            .gesture(DragGesture()
                .onChanged({ (value) in
                    let x = value.location.x
                    musicPlayer.percentVolume = min(max(x / metrics.size.width, 0), 1)
                }).onEnded({ (value) in
                    let x = value.location.x
                    let percent = x / metrics.size.width
                    musicPlayer.audioVolume = Double(percent)
                }))
        }
        .frame(width: 100, height: 20)
    }
}
