//
//  EggCup_DropZone.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 6/22/24.
//

import SwiftUI

struct EggCupDropZone: View {
    @ObservedObject private var game: EggBreakdownGame
    @State private var coverAlphaValue: Double = 1.0
    
    let index: Int
    let id: UUID
    private let eggViews: [EggType: some View] = [
        EggType.normal: getEggImage(eggType: EggType.normal),
        EggType.golden: getEggImage(eggType: EggType.golden),
        EggType.broken: getEggImage(eggType: EggType.broken)
    ]
    let playerId: UUID
    let isTargeted: Bool

    init(playerId: UUID, isTargeted: Bool, game:EggBreakdownGame, index: Int) {
        self.id = UUID()
        
        self.playerId = playerId
        self.isTargeted = isTargeted
        self.game = game
        self.index = index
    }
    
    var body: some View {
        return ZStack {
            RoundedRectangle(cornerRadius: 12)
                .frame(maxWidth: .infinity)
                .foregroundColor(isTargeted ? .teal.opacity(0.15) : Color(.secondarySystemFill))
            
            eggViews[game.dropZoneEggType[index]]
            EggCupCover(game: game, index: index)
        }
    }
}
