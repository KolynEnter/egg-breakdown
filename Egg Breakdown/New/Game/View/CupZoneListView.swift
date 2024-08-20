//
//  NewEggCupZoneListView.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 8/20/24.
//

import SwiftUI

struct CupZoneListView: View {
    @Environment(GameViewModel.self) var gameViewModel: GameViewModel
    let playerIndex: Int
    
    var body: some View {
        HStack {
            ForEach([0, 1, 2, 3], id: \.hashValue) { index in
                CupZoneView(gameViewModel: gameViewModel, index: index, playerIndex: playerIndex)
                    .background(
                        GeometryReader { geo in Color.clear
                                .onAppear {
                                    gameViewModel.cupZoneLists[playerIndex].setFrame(at: index, newFrame: geo.frame(in: .global))
                                }
                        }
                    )
            }
        }
    }
}

#Preview {
    CupZoneListView(playerIndex: 0)
        .environment(GameViewModel())
}
