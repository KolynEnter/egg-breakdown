//
//  EggCupZoneView.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 6/30/24.
//

import SwiftUI

struct EggCupZoneView: View {
    @ObservedObject private var game: EggBreakdownGame

    private let index: Int
    private let eggViews: [EggType: some View] = [
        EggType.normal: getEggCupImage(eggType: EggType.normal),
        EggType.golden: getEggCupImage(eggType: EggType.golden),
        EggType.broken: getEggCupImage(eggType: EggType.broken)
    ]

    init(game:EggBreakdownGame, index: Int) {
        self.game = game
        
        self.index = index
    }
    
    var body: some View {
        return ZStack {
            RoundedRectangle(cornerRadius: 12)
                .frame(maxWidth: .infinity)
                .foregroundColor(game.isZoneTargeted[index] ? .teal.opacity(0.15) : Color(.secondarySystemFill))
            
            eggViews[game.dropZoneEggType[index]]
            EggCupCover(game: game, index: index)
        }
    }
}
