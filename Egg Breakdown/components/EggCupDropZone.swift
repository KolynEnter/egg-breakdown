//
//  EggCup_DropZone.swift
//  Egg Breakdown
//
//  Created by Jianxin Lin on 6/22/24.
//

import SwiftUI

struct EggCupDropZone: View {
    @State private var coverAlphaValue: Double = 1.0
    
    let id: UUID
    let eggViews: [EggType: any View]
    let playerId: UUID
    let isTargeted: Bool

    init(playerId: UUID, isTargeted: Bool) {
        self.id = UUID()
        eggViews = [EggType.normal: getEggImage(eggType: EggType.normal),
                    EggType.golden: getEggImage(eggType: EggType.golden),
                    EggType.broken: getEggImage(eggType: EggType.broken)]
        
        self.playerId = playerId
        self.isTargeted = isTargeted
    }
    
    var body: some View {
        return ZStack {
            RoundedRectangle(cornerRadius: 12)
                .frame(maxWidth: .infinity)
                .foregroundColor(isTargeted ? .teal.opacity(0.15) : Color(.secondarySystemFill))
            
            EggCupCover(coverAlphaValue: coverAlphaValue)
        }
    }
}
